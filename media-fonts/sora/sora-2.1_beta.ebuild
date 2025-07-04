# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Contemporary sans-serif font witha soft geometric style"
HOMEPAGE="https://github.com/sora-xor/sora-font"
SRC_URI="https://github.com/peppapig450/nicks-overlay-vendored/releases/download/${PN}-font-v${PV//_/-}/${P}.tar.gz"
S="${WORKDIR}/sora-font"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

FONT_SUFFIX="ttf"
FONT_S="${S}/fonts/ttf/v2.1beta"
DOCS=( README.md FONTLOG.txt )

src_install() {
	font_src_install
	einstalldocs
}
