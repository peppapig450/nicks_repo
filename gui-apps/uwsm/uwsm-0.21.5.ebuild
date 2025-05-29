# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit meson python-r1
DESCRIPTION="A standalone Wayland session manager"
HOMEPAGE="https://github.com/Vladimir-csp/uwsm"
SRC_URI="https://github.com/Vladimir-csp/uwsm/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/uwsm-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="+uuctl +uwsm-app +fumon"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="
	dev-python/pyxdg
	dev-python/dbus-python${PYTHON_SINGLE_USEDEP}
	sys-apps/dbus-broker
	dev-libs/newt
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		-Ddocdir="${EPREFIX}"/usr/share/doc/${PF}
		$(meson_feature uuctl uuctl)
		$(meson_feature uwsm-app uwsm-app)
		$(meson_feature fumon fumon)
	)

	meson_src_configure
}

pkg_postinst() {
	elog "To properly configure uwsm, ensure that dbus-broker is used as the D-Bus daemon."
	elog "Consider running 'uwsm finalize' with the necessary environment variables after starting your compositor."
}
