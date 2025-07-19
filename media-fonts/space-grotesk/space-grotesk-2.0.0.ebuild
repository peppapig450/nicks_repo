# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PN_1="${PN%%-*}"
MY_PN_2="${PN##*-}"
MY_PN="${MY_PN_1^}${MY_PN_2^}"
MY_P="${MY_PN}-${PV}"

FONT_PN="${MY_PN}"
FONTDIR="/usr/share/fonts/${FONT_PN}"

DESCRIPTION="Proportional sans-serif typeface based on Space Mono"
HOMEPAGE="https://floriankarsten.github.io/space-grotesk"
SRC_URI="https://github.com/floriankarsten/space-grotesk/releases/download/${PV}/${MY_P}.zip -> ${P}.zip"

S="${WORKDIR}/${MY_P}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~ppc64 ~riscv x86"
IUSE="+ttf +otf"

BDEPEND="app-arch/unzip"

src_install() {
	if use otf; then
		FONT_S="${S}/otf" FONT_SUFFIX="otf" font_src_install
	fi

	if use ttf; then
		for dir in "${S}/ttf" "${S}/ttf/static"; do
			FONT_S="${dir}" FONT_SUFFIX="ttf" font_src_install
		done
	fi
}
