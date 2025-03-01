from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path
from typing import Any
from typing import Dict
from typing import List
from typing import Optional

import tomli
from packaging.utils import InvalidSdistFilename
from packaging.utils import InvalidWheelFilename
from packaging.utils import NormalizedName
from packaging.utils import parse_sdist_filename
from packaging.utils import parse_wheel_filename
from packaging.version import Version
from poetry.core.constraints.version import parse_constraint
from poetry.core.constraints.version import Version as PoetryVersion
from poetry.core.version import markers

from pycross.private.tools.args import FlagFileArgumentParser
from pycross.private.tools.lock_model import package_canonical_name
from pycross.private.tools.lock_model import PackageDependency
from pycross.private.tools.lock_model import PackageFile
from pycross.private.tools.lock_model import PackageKey
from pycross.private.tools.lock_model import RawLockSet
from pycross.private.tools.lock_model import RawPackage


class MismatchedVersionException(Exception):
    pass


@dataclass
class PoetryDependency:
    name: str
    spec: str
    marker: Optional[str]

    @property
    def constraint(self):
        return parse_constraint(self.spec)

    @property
    def marker_without_extra(self) -> Optional[str]:
        parsed = markers.parse_marker(self.marker)
        return str(parsed.without_extras())

    def matches(self, other: "PoetryPackage") -> bool:
        if package_canonical_name(self.name) != package_canonical_name(other.name):
            return False
        return self.constraint.allows(other.version)


@dataclass
class PoetryPackage:
    name: NormalizedName
    version: PoetryVersion
    python_versions: str
    dependencies: List[PoetryDependency]
    files: List[PackageFile]
    resolved_dependencies: List[PackageDependency]

    @property
    def key(self) -> PackageKey:
        return PackageKey.from_parts(self.name, Version(str(self.version)))

    @property
    def pypa_version(self) -> Version:
        return Version(str(self.version))

    def to_lock_package(self) -> RawPackage:
        return RawPackage(
            name=self.name,
            version=self.pypa_version,
            python_versions=self.python_versions,
            dependencies=sorted(self.resolved_dependencies, key=lambda p: p.key),
            files=sorted(self.files, key=lambda f: f.name),
        )


def get_files_for_package(
    files: List[PackageFile],
    package_name: NormalizedName,
    package_version: PoetryVersion,
) -> List[PackageFile]:
    result = []
    for file in files:
        try:
            file_package_name, file_package_version, _, _ = parse_wheel_filename(file.name)
        except InvalidWheelFilename:
            try:
                file_package_name, file_package_version = parse_sdist_filename(file.name)
            except InvalidSdistFilename:
                continue

        if file_package_name == package_name and str(file_package_version) == str(package_version):
            result.append(file)

    return result


def translate(
    project_file: Path,
    lock_file: Path,
    default_group: bool,
    optional_groups: List[str],
    all_optional_groups: bool,
) -> RawLockSet:
    try:
        with open(project_file, "rb") as f:
            project_dict = tomli.load(f)
    except Exception as e:
        raise Exception(f"Could not load project file: {project_file}: {e}")

    try:
        with open(lock_file, "rb") as f:
            lock_dict = tomli.load(f)
    except Exception as e:
        raise Exception(f"Could not load lock file: {lock_file}: {e}")

    pinned_package_specs = {}

    dependency_items = []

    if default_group:
        dependency_items.extend((project_dict.get("tool", {}).get("poetry", {}).get("dependencies", {})).items())

    groups = project_dict.get("tool", {}).get("poetry", {}).get("group", {})

    for group_name, group in groups.items():
        if all_optional_groups or group_name in optional_groups:
            dependency_items.extend(group.get("dependencies", {}).items())

    for pin, pin_info in dependency_items:
        pin = package_canonical_name(pin)
        if pin == "python":
            # Skip the special line indicating python version.
            continue
        if isinstance(pin_info, str):
            pinned_package_specs[pin] = parse_constraint(pin_info)
        else:
            if "path" in pin_info:
                # Skip path dependencies.
                continue
            pinned_package_specs[pin] = parse_constraint(pin_info["version"])

    def parse_file_info(file_info) -> PackageFile:
        file_name = file_info["file"]
        file_hash = file_info["hash"]
        assert file_hash.startswith("sha256:")
        return PackageFile(name=file_name, sha256=file_hash[7:])

    # First, build a list of package files.
    # There are scenarios when files for multiple versions of a package are present in the list. They'll be filtered
    # later.
    lock_files = lock_dict.get("metadata", {}).get("files", {})
    files_by_package_name = {
        package_name: [parse_file_info(f) for f in files] for package_name, files in lock_files.items()
    }

    # Next, pull out all Package entries in a poetry-specific model.
    poetry_packages: List[PoetryPackage] = []
    for lock_pkg in lock_dict.get("package", []):
        package_listed_name = lock_pkg["name"]
        package_name = package_canonical_name(package_listed_name)
        package_version = lock_pkg["version"]
        package_python_versions = lock_pkg["python-versions"]

        if package_python_versions == "*":
            # Special case for all python versions
            package_python_versions = ""

        dependencies = []
        for name, dep_list in lock_pkg.get("dependencies", {}).items():
            # In some cases the dependency is actually a list of alternatives, each with a different
            # marker. Generally this is not the case, but we coerce a single entry into a list of 1.
            if not isinstance(dep_list, list):
                dep_list = [dep_list]
            for dep in dep_list:
                if isinstance(dep, str):
                    marker = None
                    spec = dep
                else:
                    marker = dep.get("markers")
                    spec = dep.get("version")

                dependencies.append(PoetryDependency(name=name, spec=spec, marker=marker))

        # In older versions of poetry the list of files was held in a metadata section at the bottom of the poetry.lock file
        # The lock file format now (as of 2022-12-16), has the files specified local to each dependency as another field.
        # Here we will check for the files being present in the new location, and if not there we fall back to the older one.
        files = [parse_file_info(f) for f in lock_pkg.get("files", [])]
        if len(files) == 0:
            files = files_by_package_name[package_listed_name]

        poetry_packages.append(
            PoetryPackage(
                name=package_name,
                version=PoetryVersion.parse(package_version),
                python_versions=package_python_versions,
                dependencies=dependencies,
                files=get_files_for_package(
                    files,
                    package_name,
                    package_version,
                ),
                resolved_dependencies=[],
            )
        )

    # Next, group poetry packages by their canonical name
    packages_by_canonical_name: Dict[str, List[PoetryPackage]] = defaultdict(list)
    for package in poetry_packages:
        packages_by_canonical_name[package.name].append(package)

    # And sort the packages by version in descending order (newest first)
    for package_list in packages_by_canonical_name.values():
        package_list.sort(key=lambda p: p.version, reverse=True)

    # Next, iterate through each package's dependencies and find the newest one that matches.
    # Construct a PackageDependency and store it.
    for package in poetry_packages:
        for dep in package.dependencies:
            dependency_packages = packages_by_canonical_name[package_canonical_name(dep.name)]
            for dep_pkg in dependency_packages:
                if dep.matches(dep_pkg):
                    resolved = PackageDependency(
                        name=dep_pkg.name,
                        version=dep_pkg.pypa_version,
                        marker=dep.marker_without_extra or "",
                    )
                    package.resolved_dependencies.append(resolved)
                    break
            else:
                raise MismatchedVersionException(
                    f"Found no packages to satisfy dependency (name={dep.name}, spec={dep.spec})"
                )

    pinned_keys = {}
    for pin, pin_spec in pinned_package_specs.items():
        pin_packages = packages_by_canonical_name[pin]
        for pin_pkg in pin_packages:
            if pin_spec.allows(pin_pkg.version):
                pinned_keys[pin] = pin_pkg.key
                break
        else:
            raise MismatchedVersionException(f"Found no packages to satisfy pin (name={pin}, spec={pin_spec})")

    lock_packages = {}
    for package in poetry_packages:
        lock_package = package.to_lock_package()
        lock_packages[lock_package.key] = lock_package

    return RawLockSet(
        packages=lock_packages,
        pins=pinned_keys,
    )


def main(args: Any) -> None:
    output = args.output

    lock_set = translate(
        project_file=args.project_file,
        lock_file=args.lock_file,
        default_group=args.default,
        optional_groups=args.optional_group,
        all_optional_groups=args.all_optional_groups,
    )

    with open(output, "w") as f:
        f.write(lock_set.to_json(indent=2))


def parse_flags() -> Any:
    parser = FlagFileArgumentParser(description="Generate pycross dependency bzl file.")

    parser.add_argument(
        "--project-file",
        type=Path,
        required=True,
        help="The path to pyproject.toml.",
    )

    parser.add_argument(
        "--lock-file",
        type=Path,
        required=True,
        help="The path to pdm.lock.",
    )

    parser.add_argument(
        "--default",
        action="store_true",
        help="Whether to install dependencies from the default group.",
    )

    parser.add_argument(
        "--optional-group",
        action="append",
        default=[],
        help="Optional dependency groups to install.",
    )

    parser.add_argument(
        "--all-optional-groups",
        action="store_true",
        help="Install all optional dependency groups.",
    )

    parser.add_argument(
        "--output",
        type=Path,
        required=True,
        help="The path to the output bzl file.",
    )

    return parser.parse_args()


if __name__ == "__main__":
    main(parse_flags())
