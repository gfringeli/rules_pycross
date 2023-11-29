# This file is generated by rules_pycross.
# It is not intended for manual editing.
"""Pycross-generated dependency targets."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@jvolkman_rules_pycross//pycross:defs.bzl", "pycross_wheel_build", "pycross_wheel_library")

PINS = {
    "appnope": "appnope_0.1.3",
    "asttokens": "asttokens_2.4.1",
    "decorator": "decorator_5.1.1",
    "exceptiongroup": "exceptiongroup_1.2.0",
    "executing": "executing_2.0.1",
    "ipython": "ipython_8.17.2",
    "jedi": "jedi_0.19.1",
    "matplotlib_inline": "matplotlib_inline_0.1.6",
    "parso": "parso_0.8.3",
    "pexpect": "pexpect_4.9.0",
    "prompt_toolkit": "prompt_toolkit_3.0.41",
    "ptyprocess": "ptyprocess_0.7.0",
    "pure_eval": "pure_eval_0.2.2",
    "pygments": "pygments_2.17.2",
    "regex": "regex_2023.10.3",
    "setuptools": "setuptools_68.2.2",
    "six": "six_1.16.0",
    "stack_data": "stack_data_0.6.3",
    "traitlets": "traitlets_5.14.0",
    "wcwidth": "wcwidth_0.2.12",
    "wheel": "wheel_0.41.3",
    "zstandard": "zstandard_0.22.0",
}

# buildifier: disable=unnamed-macro
def targets():
    """Generated package targets."""

    for pin_name, pin_target in PINS.items():
        native.alias(
            name = pin_name,
            actual = ":" + pin_target,
        )

    # buildifier: disable=unused-variable
    _target = select({
        "@pycross_toolchains//:python_3.10.12_aarch64-apple-darwin_config": "@pycross_toolchains//:python_3.10.12_aarch64-apple-darwin",
        "@pycross_toolchains//:python_3.10.12_aarch64-unknown-linux-gnu_config": "@pycross_toolchains//:python_3.10.12_aarch64-unknown-linux-gnu",
        "@pycross_toolchains//:python_3.10.12_x86_64-apple-darwin_config": "@pycross_toolchains//:python_3.10.12_x86_64-apple-darwin",
        "@pycross_toolchains//:python_3.10.12_x86_64-unknown-linux-gnu_config": "@pycross_toolchains//:python_3.10.12_x86_64-unknown-linux-gnu",
        "@pycross_toolchains//:python_3.11.6_aarch64-apple-darwin_config": "@pycross_toolchains//:python_3.11.6_aarch64-apple-darwin",
        "@pycross_toolchains//:python_3.11.6_aarch64-unknown-linux-gnu_config": "@pycross_toolchains//:python_3.11.6_aarch64-unknown-linux-gnu",
        "@pycross_toolchains//:python_3.11.6_x86_64-apple-darwin_config": "@pycross_toolchains//:python_3.11.6_x86_64-apple-darwin",
        "@pycross_toolchains//:python_3.11.6_x86_64-unknown-linux-gnu_config": "@pycross_toolchains//:python_3.11.6_x86_64-unknown-linux-gnu",
        "@pycross_toolchains//:python_3.12.0_aarch64-apple-darwin_config": "@pycross_toolchains//:python_3.12.0_aarch64-apple-darwin",
        "@pycross_toolchains//:python_3.12.0_aarch64-unknown-linux-gnu_config": "@pycross_toolchains//:python_3.12.0_aarch64-unknown-linux-gnu",
        "@pycross_toolchains//:python_3.12.0_x86_64-apple-darwin_config": "@pycross_toolchains//:python_3.12.0_x86_64-apple-darwin",
        "@pycross_toolchains//:python_3.12.0_x86_64-unknown-linux-gnu_config": "@pycross_toolchains//:python_3.12.0_x86_64-unknown-linux-gnu",
    })

    pycross_wheel_library(
        name = "appnope_0.1.3",
        wheel = "@pdm_lock_wheel_appnope_0.1.3_py2.py3_none_any//file",
    )

    _asttokens_2_4_1_deps = [
        ":six_1.16.0",
    ]

    pycross_wheel_library(
        name = "asttokens_2.4.1",
        deps = _asttokens_2_4_1_deps,
        wheel = "@pdm_lock_wheel_asttokens_2.4.1_py2.py3_none_any//file",
    )

    pycross_wheel_library(
        name = "decorator_5.1.1",
        wheel = "@pdm_lock_wheel_decorator_5.1.1_py3_none_any//file",
    )

    pycross_wheel_library(
        name = "exceptiongroup_1.2.0",
        wheel = "@pdm_lock_wheel_exceptiongroup_1.2.0_py3_none_any//file",
    )

    pycross_wheel_library(
        name = "executing_2.0.1",
        wheel = "@pdm_lock_wheel_executing_2.0.1_py2.py3_none_any//file",
    )

    _ipython_8_17_2_deps = [
        ":decorator_5.1.1",
        ":jedi_0.19.1",
        ":matplotlib_inline_0.1.6",
        ":pexpect_4.9.0",
        ":prompt_toolkit_3.0.41",
        ":pygments_2.17.2",
        ":stack_data_0.6.3",
        ":traitlets_5.14.0",
    ] + select({
        "@pycross_toolchains//:python_3.10.12_aarch64-apple-darwin_config": [
            ":appnope_0.1.3",
            ":exceptiongroup_1.2.0",
        ],
        "@pycross_toolchains//:python_3.10.12_aarch64-unknown-linux-gnu_config": [
            ":exceptiongroup_1.2.0",
        ],
        "@pycross_toolchains//:python_3.10.12_x86_64-apple-darwin_config": [
            ":appnope_0.1.3",
            ":exceptiongroup_1.2.0",
        ],
        "@pycross_toolchains//:python_3.10.12_x86_64-unknown-linux-gnu_config": [
            ":exceptiongroup_1.2.0",
        ],
        "@pycross_toolchains//:python_3.11.6_aarch64-apple-darwin_config": [
            ":appnope_0.1.3",
        ],
        "@pycross_toolchains//:python_3.11.6_x86_64-apple-darwin_config": [
            ":appnope_0.1.3",
        ],
        "@pycross_toolchains//:python_3.12.0_aarch64-apple-darwin_config": [
            ":appnope_0.1.3",
        ],
        "@pycross_toolchains//:python_3.12.0_x86_64-apple-darwin_config": [
            ":appnope_0.1.3",
        ],
        "//conditions:default": [],
    })

    pycross_wheel_library(
        name = "ipython_8.17.2",
        deps = _ipython_8_17_2_deps,
        wheel = "@pdm_lock_wheel_ipython_8.17.2_py3_none_any//file",
    )

    _jedi_0_19_1_deps = [
        ":parso_0.8.3",
    ]

    pycross_wheel_library(
        name = "jedi_0.19.1",
        deps = _jedi_0_19_1_deps,
        wheel = "@pdm_lock_wheel_jedi_0.19.1_py2.py3_none_any//file",
    )

    _matplotlib_inline_0_1_6_deps = [
        ":traitlets_5.14.0",
    ]

    pycross_wheel_library(
        name = "matplotlib_inline_0.1.6",
        deps = _matplotlib_inline_0_1_6_deps,
        wheel = "@pdm_lock_wheel_matplotlib_inline_0.1.6_py3_none_any//file",
    )

    pycross_wheel_library(
        name = "parso_0.8.3",
        wheel = "@pdm_lock_wheel_parso_0.8.3_py2.py3_none_any//file",
    )

    _pexpect_4_9_0_deps = [
        ":ptyprocess_0.7.0",
    ]

    pycross_wheel_library(
        name = "pexpect_4.9.0",
        deps = _pexpect_4_9_0_deps,
        wheel = "@pdm_lock_wheel_pexpect_4.9.0_py2.py3_none_any//file",
    )

    _prompt_toolkit_3_0_41_deps = [
        ":wcwidth_0.2.12",
    ]

    pycross_wheel_library(
        name = "prompt_toolkit_3.0.41",
        deps = _prompt_toolkit_3_0_41_deps,
        wheel = "@pdm_lock_wheel_prompt_toolkit_3.0.41_py3_none_any//file",
    )

    pycross_wheel_library(
        name = "ptyprocess_0.7.0",
        wheel = "@pdm_lock_wheel_ptyprocess_0.7.0_py2.py3_none_any//file",
    )

    pycross_wheel_library(
        name = "pure_eval_0.2.2",
        wheel = "@pdm_lock_wheel_pure_eval_0.2.2_py3_none_any//file",
    )

    pycross_wheel_library(
        name = "pygments_2.17.2",
        wheel = "@pdm_lock_wheel_pygments_2.17.2_py3_none_any//file",
    )

    _regex_2023_10_3_build_deps = [
        ":setuptools_68.2.2",
        ":wheel_0.41.3",
    ]

    pycross_wheel_build(
        name = "_build_regex_2023.10.3",
        sdist = "@pdm_lock_sdist_regex_2023.10.3//file",
        target_environment = _target,
        deps = _regex_2023_10_3_build_deps,
        tags = ["manual"],
    )

    pycross_wheel_library(
        name = "regex_2023.10.3",
        wheel = ":_build_regex_2023.10.3",
    )

    pycross_wheel_library(
        name = "setuptools_68.2.2",
        wheel = "@pdm_lock_wheel_setuptools_68.2.2_py3_none_any//file",
    )

    pycross_wheel_library(
        name = "six_1.16.0",
        wheel = "@pdm_lock_wheel_six_1.16.0_py2.py3_none_any//file",
    )

    _stack_data_0_6_3_deps = [
        ":asttokens_2.4.1",
        ":executing_2.0.1",
        ":pure_eval_0.2.2",
    ]

    pycross_wheel_library(
        name = "stack_data_0.6.3",
        deps = _stack_data_0_6_3_deps,
        wheel = "@pdm_lock_wheel_stack_data_0.6.3_py3_none_any//file",
    )

    pycross_wheel_library(
        name = "traitlets_5.14.0",
        wheel = "@pdm_lock_wheel_traitlets_5.14.0_py3_none_any//file",
    )

    pycross_wheel_library(
        name = "wcwidth_0.2.12",
        wheel = "@pdm_lock_wheel_wcwidth_0.2.12_py2.py3_none_any//file",
    )

    pycross_wheel_library(
        name = "wheel_0.41.3",
        wheel = "@pdm_lock_wheel_wheel_0.41.3_py3_none_any//file",
    )

    pycross_wheel_library(
        name = "zstandard_0.22.0",
        wheel = "@//pdm:zstandard_build",
    )

# buildifier: disable=unnamed-macro
def repositories():
    """Generated package repositories."""

    maybe(
        http_file,
        name = "pdm_lock_sdist_regex_2023.10.3",
        urls = [
            "https://files.pythonhosted.org/packages/6b/38/49d968981b5ec35dbc0f742f8219acab179fc1567d9c22444152f950cf0d/regex-2023.10.3.tar.gz",
        ],
        sha256 = "3fef4f844d2290ee0ba57addcec17eec9e3df73f10a2748485dfd6a3a188cc0f",
        downloaded_file_path = "regex-2023.10.3.tar.gz",
    )

    maybe(
        http_file,
        name = "pdm_lock_sdist_zstandard_0.22.0",
        urls = [
            "https://files.pythonhosted.org/packages/5d/91/2162ab4239b3bd6743e8e407bc2442fca0d326e2d77b3f4a88d90ad5a1fa/zstandard-0.22.0.tar.gz",
        ],
        sha256 = "8226a33c542bcb54cd6bd0a366067b610b41713b64c9abec1bc4533d69f51e70",
        downloaded_file_path = "zstandard-0.22.0.tar.gz",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_appnope_0.1.3_py2.py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/41/4a/381783f26df413dde4c70c734163d88ca0550a1361cb74a1c68f47550619/appnope-0.1.3-py2.py3-none-any.whl",
        ],
        sha256 = "265a455292d0bd8a72453494fa24df5a11eb18373a60c7c0430889f22548605e",
        downloaded_file_path = "appnope-0.1.3-py2.py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_asttokens_2.4.1_py2.py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/45/86/4736ac618d82a20d87d2f92ae19441ebc7ac9e7a581d7e58bbe79233b24a/asttokens-2.4.1-py2.py3-none-any.whl",
        ],
        sha256 = "051ed49c3dcae8913ea7cd08e46a606dba30b79993209636c4875bc1d637bc24",
        downloaded_file_path = "asttokens-2.4.1-py2.py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_decorator_5.1.1_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/d5/50/83c593b07763e1161326b3b8c6686f0f4b0f24d5526546bee538c89837d6/decorator-5.1.1-py3-none-any.whl",
        ],
        sha256 = "b8c3f85900b9dc423225913c5aace94729fe1fa9763b38939a95226f02d37186",
        downloaded_file_path = "decorator-5.1.1-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_exceptiongroup_1.2.0_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/b8/9a/5028fd52db10e600f1c4674441b968cf2ea4959085bfb5b99fb1250e5f68/exceptiongroup-1.2.0-py3-none-any.whl",
        ],
        sha256 = "4bfd3996ac73b41e9b9628b04e079f193850720ea5945fc96a08633c66912f14",
        downloaded_file_path = "exceptiongroup-1.2.0-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_executing_2.0.1_py2.py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/80/03/6ea8b1b2a5ab40a7a60dc464d3daa7aa546e0a74d74a9f8ff551ea7905db/executing-2.0.1-py2.py3-none-any.whl",
        ],
        sha256 = "eac49ca94516ccc753f9fb5ce82603156e590b27525a8bc32cce8ae302eb61bc",
        downloaded_file_path = "executing-2.0.1-py2.py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_ipython_8.17.2_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/20/45/18f0dc2cbc3ee6680a004f620fb1400c6511ded0a76a2dd241813786ce73/ipython-8.17.2-py3-none-any.whl",
        ],
        sha256 = "1e4d1d666a023e3c93585ba0d8e962867f7a111af322efff6b9c58062b3e5444",
        downloaded_file_path = "ipython-8.17.2-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_jedi_0.19.1_py2.py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/20/9f/bc63f0f0737ad7a60800bfd472a4836661adae21f9c2535f3957b1e54ceb/jedi-0.19.1-py2.py3-none-any.whl",
        ],
        sha256 = "e983c654fe5c02867aef4cdfce5a2fbb4a50adc0af145f70504238f18ef5e7e0",
        downloaded_file_path = "jedi-0.19.1-py2.py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_matplotlib_inline_0.1.6_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/f2/51/c34d7a1d528efaae3d8ddb18ef45a41f284eacf9e514523b191b7d0872cc/matplotlib_inline-0.1.6-py3-none-any.whl",
        ],
        sha256 = "f1f41aab5328aa5aaea9b16d083b128102f8712542f819fe7e6a420ff581b311",
        downloaded_file_path = "matplotlib_inline-0.1.6-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_parso_0.8.3_py2.py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/05/63/8011bd08a4111858f79d2b09aad86638490d62fbf881c44e434a6dfca87b/parso-0.8.3-py2.py3-none-any.whl",
        ],
        sha256 = "c001d4636cd3aecdaf33cbb40aebb59b094be2a74c556778ef5576c175e19e75",
        downloaded_file_path = "parso-0.8.3-py2.py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_pexpect_4.9.0_py2.py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/9e/c3/059298687310d527a58bb01f3b1965787ee3b40dce76752eda8b44e9a2c5/pexpect-4.9.0-py2.py3-none-any.whl",
        ],
        sha256 = "7236d1e080e4936be2dc3e326cec0af72acf9212a7e1d060210e70a47e253523",
        downloaded_file_path = "pexpect-4.9.0-py2.py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_prompt_toolkit_3.0.41_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/1f/9d/be9b01085bbd67a71c4b6aa02518fade8104e7a2224e5de5e947811d7176/prompt_toolkit-3.0.41-py3-none-any.whl",
        ],
        sha256 = "f36fe301fafb7470e86aaf90f036eef600a3210be4decf461a5b1ca8403d3cb2",
        downloaded_file_path = "prompt_toolkit-3.0.41-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_ptyprocess_0.7.0_py2.py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/22/a6/858897256d0deac81a172289110f31629fc4cee19b6f01283303e18c8db3/ptyprocess-0.7.0-py2.py3-none-any.whl",
        ],
        sha256 = "4b41f3967fce3af57cc7e94b888626c18bf37a083e3651ca8feeb66d492fef35",
        downloaded_file_path = "ptyprocess-0.7.0-py2.py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_pure_eval_0.2.2_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/2b/27/77f9d5684e6bce929f5cfe18d6cfbe5133013c06cb2fbf5933670e60761d/pure_eval-0.2.2-py3-none-any.whl",
        ],
        sha256 = "01eaab343580944bc56080ebe0a674b39ec44a945e6d09ba7db3cb8cec289350",
        downloaded_file_path = "pure_eval-0.2.2-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_pygments_2.17.2_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/97/9c/372fef8377a6e340b1704768d20daaded98bf13282b5327beb2e2fe2c7ef/pygments-2.17.2-py3-none-any.whl",
        ],
        sha256 = "b27c2826c47d0f3219f29554824c30c5e8945175d888647acd804ddd04af846c",
        downloaded_file_path = "pygments-2.17.2-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_setuptools_68.2.2_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/bb/26/7945080113158354380a12ce26873dd6c1ebd88d47f5bc24e2c5bb38c16a/setuptools-68.2.2-py3-none-any.whl",
        ],
        sha256 = "b454a35605876da60632df1a60f736524eb73cc47bbc9f3f1ef1b644de74fd2a",
        downloaded_file_path = "setuptools-68.2.2-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_six_1.16.0_py2.py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/d9/5a/e7c31adbe875f2abbb91bd84cf2dc52d792b5a01506781dbcf25c91daf11/six-1.16.0-py2.py3-none-any.whl",
        ],
        sha256 = "8abb2f1d86890a2dfb989f9a77cfcfd3e47c2a354b01111771326f8aa26e0254",
        downloaded_file_path = "six-1.16.0-py2.py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_stack_data_0.6.3_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/f1/7b/ce1eafaf1a76852e2ec9b22edecf1daa58175c090266e9f6c64afcd81d91/stack_data-0.6.3-py3-none-any.whl",
        ],
        sha256 = "d5558e0c25a4cb0853cddad3d77da9891a08cb85dd9f9f91b9f8cd66e511e695",
        downloaded_file_path = "stack_data-0.6.3-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_traitlets_5.14.0_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/a7/1d/7d07e1b152b419a8a9c7f812eeefd408a0610d869489ee2e86973486713f/traitlets-5.14.0-py3-none-any.whl",
        ],
        sha256 = "f14949d23829023013c47df20b4a76ccd1a85effb786dc060f34de7948361b33",
        downloaded_file_path = "traitlets-5.14.0-py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_wcwidth_0.2.12_py2.py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/31/b1/a59de0ad3aabb17523a39804f4c6df3ae87ead053a4e25362ae03d73d03a/wcwidth-0.2.12-py2.py3-none-any.whl",
        ],
        sha256 = "f26ec43d96c8cbfed76a5075dac87680124fa84e0855195a6184da9c187f133c",
        downloaded_file_path = "wcwidth-0.2.12-py2.py3-none-any.whl",
    )

    maybe(
        http_file,
        name = "pdm_lock_wheel_wheel_0.41.3_py3_none_any",
        urls = [
            "https://files.pythonhosted.org/packages/fa/7f/4c07234086edbce4a0a446209dc0cb08a19bb206a3ea53b2f56a403f983b/wheel-0.41.3-py3-none-any.whl",
        ],
        sha256 = "488609bc63a29322326e05560731bf7bfea8e48ad646e1f5e40d366607de0942",
        downloaded_file_path = "wheel-0.41.3-py3-none-any.whl",
    )
