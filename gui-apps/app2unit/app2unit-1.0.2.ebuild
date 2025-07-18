# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Shell script to launch commands as systemd units"
HOMEPAGE="https://github.com/Vladimir-csp/app2unit"
SRC_URI="https://github.com/Vladimir-csp/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+man"

BDEPEND="man? ( app-text/scdoc )"

src_compile() {
	if use man; then
		scdoc < ./app2unit.1.scd > ./app2unit.1 || die
	fi
}

src_install() {
	if use man; then
		doman app2unit.1
	fi
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install-bin
}
