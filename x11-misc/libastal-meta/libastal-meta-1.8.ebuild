# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="libastal meta pacakge, including all libastal services"
HOMEPAGE="https://github.com/Aylur/astal"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="
	apps auth battery bluetooth cava greet hyprland io mpris
	network notifd power-profiles river tray wireplumber
"

RDEPEND="
	x11-libs/libastal
	x11-libs/libastal-gtk4
	apps? ( x11-libs/libastal-apps )
	auth? ( x11-libs/libastal-auth )
	battery? ( x11-libs/libastal-battery )
	bluetooth? ( x11-libs/libastal-bluetooth )
	cava? ( x11-libs/libastal-cava )
	greet? ( x11-libs/libastal-greet )
	hyprland? ( x11-libs/libastal-hyprland )
	io? ( x11-libs/libastal-io )
	mpris? ( x11-libs/libastal-mpris )
	network? ( x11-libs/libastal-network )
	notifd? ( x11-libs/libastal-notifd )
	power-profiles? ( x11-libs/libastal-power-profiles )
	river? ( x11-libs/libastal-river )
	tray? ( x11-libs/libastal-tray )
	wireplumber? ( x11-libs/libastal-wireplumber )
"
