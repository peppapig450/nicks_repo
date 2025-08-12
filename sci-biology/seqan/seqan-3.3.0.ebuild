# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ Sequence Analysis Library"
HOMEPAGE="https://www.seqan.de/"
SRC_URI="https://github.com/seqan/seqan3/releases/download/${PV}/seqan3-${PV}-Source.tar.xz"
S="${WORKDIR}/seqan3-${PV}-Source"

LICENSE="BSD GPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="cpu_flags_x86_sse4_2"
REQUIRED_USE="cpu_flags_x86_sse4_2"

RDEPEND="
	app-arch/bzip2:=
	dev-cpp/range-v3
	dev-libs/cereal
	sci-libs/lemon
	dev-cpp/sdsl-lite
	sys-libs/zlib:=
"

DEPEND="${RDEPEND}"

src_configure() {
	# Allow building with clang, there's no reason for the GCC only block
	# since this is a header only package
	local -a mycmakeargs=(
		-DSEQAN3_DISABLE_COMPILER_CHECK=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc -r doc/*
}
