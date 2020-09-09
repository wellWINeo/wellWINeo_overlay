# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop pax-utils unpacker xdg-utils

MY_PN="${PN/-gui/}"

DESCRIPTION="The desktop vault (Windows, macOS, & Linux). "
HOMEPAGE="https://bitwarden.com/"
SRC_URI="https://github.com/${MY_PN}/desktop/releases/download/v${PV}/Bitwarden-${PV}-amd64.deb -> ${P}.deb"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/nodejs"
RDEPEND="${DEPEND}"

QA_PREBUILT="opt/Bitwarden/chrome-sandbox
			opt/Bitwarden/libEGL.so
			opt/Bitwarden/libffmpeg.so
			opt/Bitwarden/libGLESv2.so
			opt/Bitwarden/swiftshader/libEGL.so
			opt/Bitwarden/swiftshader/libGLESv2.so
			opt/Bitwarden/"

S=${WORKDIR}

src_prepare(){
		default
		sed -i usr/share/icons/hicolor/512x512/apps/${MY_PN}.png \
		-e 's|opt/bitwarden|opt/Bitwarden'
}

src_install(){
		doicon usr/share/icons/hicolor/512x512/apps/${MY_PN}.png

		doicon -s 512 usr/share/icons/hicolor/512x512/apps/${MY_PN}.png

		domenu usr/share/applications/${MY_PN}.desktop

		insinto /opt
		doins -r opt/Bitwarden
		fperms +x /opt/Bitwarden/${MY_PN}
		dosym ../../opt/Bitwarden/${MY_PN} usr/bin/${MY_PN}

		pax-mark -m "${ED%/}"/opt/${MY_PN}/${MY_PN}
}

pkg_postinst(){
		xdg_desktop_database_update
		xdg_icon_cache_update
		xdg_mimeinfo_update
}

pkg_postrm(){
		xdg_desktop_database_update
		xdg_icon_cache_update
		xdg_mimeinfo_update
}
