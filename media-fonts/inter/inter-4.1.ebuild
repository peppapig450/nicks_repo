# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="A typeface specially designed for user interfaces"
HOMEPAGE="https://rsms.me/inter"
SRC_URI="https://github.com/rsms/inter/releases/download/v${PV}/${PN^}-${PV}.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~ppc64 ~riscv x86"
IUSE="otf ttf"

BDEPEND="app-arch/unzip"

DOCS=( LICENSE.txt help.txt )

src_install() {
	if use otf; then
		FONT_S="${S}/extras/otf" FONT_SUFFIX="otf" font_src_install
	fi
	if use ttf; then
		FONT_S="${S}/extras/ttf" FONT_SUFFIX="ttf" font_src_install
	fi

	FONT_S="${S}" FONT_SUFFIX="ttc ttf" font_src_install
}

