# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

inherit cargo

DESCRIPTION="spotify_player is a fast, easy to use, and configurable terminal music player."
HOMEPAGE="https://github.com/aome510/spotify-player"
SRC_URI="
	https://github.com/aome510/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/peppapig450/nicks-overlay-vendored/releases/download/${PN}-v${PV}/${P}-vendor.tar.xz
"
LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 ISC LGPL-3 LGPL-3+ MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

IUSE="daemon image +libnotify +media-control pulseaudio sixel +streaming"
REQUIRED_USE="
	sixel? ( image )
	daemon? ( streaming )
"
DEPEND="
	dev-libs/openssl
	sys-apps/dbus
	libnotify? ( x11-libs/libnotify )
	pulseaudio? ( media-libs/libpulse )
	sixel? ( media-libs/libsixel )
	streaming? ( media-libs/alsa-lib )
"
RDEPEND="${DEPEND}"

src_configure() {
	initfeatures=(
		"$(usex daemon daemon '')"
		"$(usex image image '')"
		"$(usex libnotify notify '')"
		"$(usex media-control media-control '')"
		"$(usex pulseaudio pulseaudio-backend alsa-backend)"
		"$(usex sixel sixel '')"
		"$(usex streaming streaming '')"
	)
	newfeatures=$(
		IFS=,
		echo "${initfeatures[*]}"
	) || die
	cargo_src_configure --features ${newfeatures} --no-default-features
}

src_install() {
	cargo_src_install --path ./spotify_player
}
QA_FLAGS_IGNORED="usr/bin/spotify_player"
