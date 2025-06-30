# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Simple pinentry client via 'fuzzel', 'rofi', or 'wofi'."
HOMEPAGE="https://github.com/peppapig450/pinentry-menu"
SRC_URI="https://github.com/peppapig450/pinentry-menu/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	|| (
		gui-apps/fuzzel
		gui-apps/wofi
		x11-misc/rofi
	)
"

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	elog "To use pinentry-menu, edit your gpg-agent.conf file to include:"
	elog "pinentry-program /usr/bin/pinentry-menu"
}
