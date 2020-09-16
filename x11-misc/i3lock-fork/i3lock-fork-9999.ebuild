# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2"

EAPI=7

inherit git-r3 toolchain-funcs autotools

MY_PN="${PN/-fork/}"

DESCRIPTION="i3lock fork with clock and other tweaks"
HOMEPAGE="https://github.com/Lixxia/i3lock"
SRC_URI=""

EGIT_REPO_URI="https://github.com/Lixxia/${MY_PN}.git"

LICENSE="custom"
SLOT="0"
KEYWOARDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

RDEPEND="
		>=x11-libs/libxkbcommon-0.5.0[X]
		dev-libs/libev
		sys-libs/pam
		x11-libs/cairo[X,xcb(+)]
		x11-libs/libxcb[xkb]
		x11-libs/xcb-util
		x11-libs/xcb-util-xrm
		x11-libs/libxkbcommon
		!x11-misc/i3lock
		"

DEPEND="
		${RDEPEND}
		virtual/pkgconfig
"

DOCS=( CHANGELOG README.md )


src_prepare() {
	default
	sed -i -e 's#default_sanitizers=address#default_sanitizers=#' configure.ac || die
	eautoreconf

}










