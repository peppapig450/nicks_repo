# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_COMMIT="bb2eebb2de8a556661c00ba3c5b4c33b7c2c7a25"
DESCRIPTION="Succinct Data Structure Library"
HOMEPAGE="https://github.com/xxsds/sdsl-lite"
SRC_URI="https://github.com/xxsds/sdsl-lite/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"
IUSE="doc examples"

BDEPEND="
    >=dev-build/cmake-3.18
    doc? ( app-text/doxygen )
"

DEPEND=""
RDEPEND=""

src_prepare() {
    cmake_src_prepare

    # Remove the custom install script that might interfere
    rm -f install.sh install.bat || die
}

src_configure() {
    local mycmakeargs=(
        -DSDSL_BUILD_TESTS=OFF
        -DSDSL_BUILD_EXAMPLES=$(usex examples)
        -DSDSL_BUILD_TUTORIAL=OFF
        -DSDSL_GENERATE_DOC=$(usex doc)
        -DSDSL_HEADER_TEST=OFF
        -DSDSL_CODE_COVERAGE=OFF
    )

    cmake_src_configure
}

src_compile() {
    cmake_src_compile

    if use doc; then
        cmake_build docs
    fi
}


src_install() {
    # Install headers manually since this is header-only
    insinto /usr/include
    doins -r include/sdsl

    # Install pkg-config file
    insinto /usr/$(get_libdir)/pkgconfig
    cat > "${T}"/sdsl-lite.pc <<EOF || die
prefix=${EPREFIX}/usr
exec_prefix=\${prefix}
includedir=\${prefix}/include

Name: sdsl-lite
Description: Succinct Data Structure Library
Version: ${PV}
URL: https://github.com/xxsds/sdsl-lite
Cflags: -I\${includedir}
EOF
    doins "${T}"/sdsl-lite.pc

    # Install examples if requested
    if use examples; then
        docinto examples
        dodoc -r examples/.

        # Make examples more accessible
        insinto /usr/share/${PN}/examples
        doins -r examples/*
    fi

    # Install documentation
    if use doc && [[ -d "${BUILD_DIR}/doc" ]]; then
        docinto html
        dodoc -r "${BUILD_DIR}"/doc/html/.
    fi

    # Install additional documentation
    dodoc README.md AUTHORS

    # Install tutorial and benchmark documentation
    docinto tutorial
    dodoc -r tutorial/.

    if [[ -d benchmark ]]; then
        docinto benchmark
        dodoc -r benchmark/README.md
        dodoc -r benchmark/*/README.md 2>/dev/null || true
    fi
}

pkg_postinst() {
    elog "SDSL v3 is a header-only library."
    elog "Include headers with: #include <sdsl/...>"
    elog ""
    if use examples; then
        elog "Example programs are installed in:"
        elog "  /usr/share/${PN}/examples/"
        elog ""
        elog "Compile examples with:"
        elog "  g++ -std=c++17 -I/usr/include example.cpp"
    fi
    elog "The library supports C++17, C++20, and C++23."
    elog "See documentation at: https://github.com/xxsds/sdsl-lite"
}
