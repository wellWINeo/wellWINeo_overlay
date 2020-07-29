# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils unpacker xdg-utils

DESCRIPTION="Electron wrapper for todoist web client."
HOMEPAGE="https://github.com/KryDos/todoist-linux"

MY_PN="${PN/-bin/}"
SRC_URI="https://github.com/KryDos/todoist-linux/releases/download/${PV}/${MY_PN}_${PV}_amd64.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

#libxss
RDEPEND="net-dns/c-ares
		media-video/ffmpeg
		x11-libs/gtk+
		net-libs/http-parser
		dev-libs/libevent
		media-libs/libvpx
		dev-libs/libxslt
		x11-libs/libXScrnSaver
		dev-libs/nss
		dev-libs/re2
		x11-libs/libnotify"

QA_PREBUILT="opt/todoist/chrome-sandbox
		opt/todoist/
		opt/todoist/libffmpeg.so
		opt/todoist/libEGL.so
		opt/todoist/libGLESv2
		opt/todoist/swiftshader/libEGL.so
		opt/todoist/swiftshader/libGLESv2.so"

S=${WORKDIR}

src_prepare() {
		default

		sed -i usr/share/icons/hicolor/512x512/apps/${MY_PN}.png \
		-e 's|opt/todoist|opt/Todoist'
}

src_install() {
		doicon usr/share/icons/hicolor/512x512/apps/${MY_PN}.png
		
		doicon -s 512 usr/share/icons/hicolor/512x512/apps/${MY_PN}.png

		domenu usr/share/applications/${MY_PN}.desktop

		insinto /opt
		doins -r opt/Todoist
		fperms +x /opt/Todoist/${MY_PN}
		dosym ../../opt/todoist/${MY_PN} usr/bin/${MY_PN}

		pax-mark -m "${ED%/}"/opt/${MY_PN}/${MY_PN}
}

pkg_postinst() {
		xdg_desktop_database_update
		xdg_icon_cache_update
		xdg_mimeinfo_update
}

pkg_postrm() {
		xdg_desktop_database_update
		xdg_icon_cache_update
		xdg_mimeinfo_update
}

