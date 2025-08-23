# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font unpacker

DESCRIPTION="A free and open-source typeface for developers"
HOMEPAGE="https://monaspace.github.next"
SRC_URI+="
	frozen? (
		https://github.com/githubnext/monaspace/releases/download/v${PV}/${PN}-frozen-v${PV}.zip
	)
	otf? (
		https://github.com/githubnext/monaspace/releases/download/v${PV}/${PN}-static-v${PV}.zip
	)
	variable? (
		https://github.com/githubnext/monaspace/releases/download/v${PV}/${PN}-variable-v${PV}.zip
	)
	nerdfonts? (
		https://github.com/githubnext/monaspace/releases/download/v${PV}/${PN}-nerdfonts-v${PV}.zip
	)
"

S="${WORKDIR}/monaspace-v${PV}"
LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

FONT_S="${S}/fonts/total"
FONT_SUFFIX=""
IUSE="frozen +otf variable nerdfonts"
REQUIRED_USE="|| ( frozen otf variable nerdfonts )"

BDEPEND="app-arch/unzip"

src_unpack() {
	mkdir -p "${S}" || die
	cd "${S}" || die

	for flag in frozen variable nerdfonts; do
		use "$flag" && unpack_zip "${DISTDIR}/${PN}-${flag}-v${PV}.zip"
	done

	use otf && unpack_zip "${DISTDIR}/${PN}-static-v${PV}.zip"
}

src_prepare() {
	default

	mkdir -p "${S}/fonts/total" || die

	if use frozen ; then
		mv "${S}/Frozen Fonts/"*/* "${S}/fonts/total" || die
		FONT_SUFFIX="${FONT_SUFFIX} ttf"
	fi

	if use otf ; then
		mv "${S}/Static Fonts/"*/* "${S}/fonts/total" || die
		FONT_SUFFIX="${FONT_SUFFIX} otf"
	fi

	if use variable ; then
		mv "${S}/Variable Fonts/"*/* "${S}/fonts/total" || die
		FONT_SUFFIX="${FONT_SUFFIX} ttf"
	fi

	if use nerdfonts ; then
		mv "${S}/NerdFonts/"*/* "${S}/fonts/total" || die
		FONT_SUFFIX="${FONT_SUFFIX} otf"
	fi
}
