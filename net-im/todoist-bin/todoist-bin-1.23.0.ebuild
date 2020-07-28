# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils unpacker xdg-utils

DESCRIPTION="Electron wrapper for todoist web client."
HOMEPAGE="https://github.com/KryDos/todoist-linux"

RAW_PN="${PN/-bin/}"
SRC_URI="https://github.com/KryDos/todoist-linux/releases/download/${PV}/${RAW_PN}_${PV}_amd64.deb -> ${P}.deb"

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

		sed -i usr/share/icons/hicolor/512x512/apps/todoist.png \
		-e 's|opt/todoist|opt/Todoist'
}

src_install() {
		doicon usr/share/icons/hicolor/512x512/apps/todoist.png
		
		doicon -s 512 usr/share/icons/hicolor/512x512/apps/todoist.png

		domenu usr/share/applications/todoist.desktop

		insinto /opt
		doins -r opt/todoist
		fperms +x /opt/todoist/todoist
		dosym ../../opt/todoist/todoist usr/bin/todoist

		pax-mark -m "${ED%/}"/opt/todoist/todoist
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

