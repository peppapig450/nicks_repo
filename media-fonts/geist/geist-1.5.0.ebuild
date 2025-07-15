# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Legible and simple sans-serif typeface by Vercel"
HOMEPAGE="https://github.com/vercel/geist-font"
SRC_URI="https://github.com/vercel/geist-font/releases/download/${PV}/${PN}-font-${PV}.zip -> ${P}.zip"

S="${WORKDIR}/${PN}-font-${PV}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~ppc64 ~riscv x86"

IUSE="+otf +ttf variable"
REQUIRED_USE="|| ( otf ttf variable )"

BDEPEND="app-arch/unzip"
HTML_DOCS=( DESCRIPTION.en_us.html ARTICLE.en_us.html )
DOCS=( OFL.txt )

src_install() {
	local font_name font_dir
	for font_name in Geist GeistMono; do
		font_dir="${S}/fonts/${font_name}"
		if use otf; then
			FONT_S="${font_dir}/otf" FONT_SUFFIX="otf" font_src_install
		fi
		if use ttf; then
			FONT_S="${font_dir}/ttf" FONT_SUFFIX="ttf" font_src_install
		fi
		if use variable; then
			FONT_S="${font_dir}/variable" FONT_SUFFIX="ttf" font_src_install
		fi
	done
}
