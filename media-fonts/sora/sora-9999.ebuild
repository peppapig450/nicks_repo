# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font git-r3

DESCRIPTION="Contemporary sans-serif font with a soft geometric style"
HOMEPAGE="https://fonts.google.com/specimen/Sora"
EGIT_REPO_URI="https://github.com/sora-xor/sora-font.git"

LICENSE="OFL-1.1"
SLOT="0"

FONT_SUFFIX="ttf"
FONT_S="${S}/fonts/variable"
