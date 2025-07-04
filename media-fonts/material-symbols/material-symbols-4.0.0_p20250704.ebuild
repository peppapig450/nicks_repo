# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Material Design icon symbols by Google"
HOMEPAGE="https://github.com/google/material-design-icons"
SRC_URI="https://github.com/peppapig450/nicks-overlay-vendored/releases/download/${P}/${P}.tar.xz"

S="${WORKDIR}/material-design-icons"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~ppc64 ~riscv x86"

IUSE="+otf ttf variable"

REQUIRED_USE="|| ( otf ttf variable )"

src_install() {
	if use otf; then
		FONT_S="${S}/font" FONT_SUFFIX="otf" font_src_install
	fi
	if use ttf; then
		FONT_S="${S}/font" FONT_SUFFIX="f" font_src_install
	fi
	if use variable; then
		FONT_S="${S}/variablefont" FONT_SUFFIX="ttf" font_src_install
	fi
}
