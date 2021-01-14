# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Resource monitor that shows usage and stats for processor, memory, disks, network and processes. 
Python port of bashtop."
HOMEPAGE="https://github.com/aristocratos/bpytop"
SRC_URI="https://github.com/aristocratos/${PN}/archive/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

S="${WORKDIR}/${P}"

BDEPEND="sys-devel/make"

RDEPEND=">=dev-python/psutil-5.7.0
        >=dev-lang/python-3.6.0"

src_install() {
        emake PREFIX=/usr DESTDIR=${D} install || "make install failed"
}
