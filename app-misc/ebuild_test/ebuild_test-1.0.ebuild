# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Ebuild simply demo"
HOMEPAGE="https://github.com/wellWINeo/ebuild_test"
SRC_URI="https://github.com/wellWINeo/${PN}/archive/${PV}.tar.gz"

LICENSE="*"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}/${P}"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	make DETSDIR=${D} install || die "make install failed"
}
