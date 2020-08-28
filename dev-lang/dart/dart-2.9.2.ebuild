# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit flag-o-matic eutils python-r1 llvm ninja-utils

DESCRIPTION="A client-optimized language for fast apps on any platform"
HOMEPAGE="https://dart.dev/"
SRC_URI="http://commondatastorage.googleapis.com/dart-archive/channels/stable/raw/${PV}/src/${P}.tar.gz"

LICENSE="BSD-3 clause"
SLOT="0"
KEYWORDS="amd64"
IUSE="-debug"

REDEPEND=">=sys-devel/clang-5
		>=sys-devel/llvm-5"
DEPEND="dev-util/gn
		${RDEPEND}"


S="${S}/${PN}"
BUILD_DIR="${S}/out"

llvm_check_deps() {
		has_version "sys-devel/clang:${LLVM_SLOT}"
}

src_prepare() {
	cd ${S}
	rm -R debian
	cd ${S}
	default
}

src_configure() {
	python_setup
	mkdir ${BUILD_DIR}
	cd ${BUILD_DIR}
}

src_compile() {
	if use debug ; then
		./tools/build.py  --mode debug --arch x64 create_sdk
	else 
		./tools/build.py --mode release --arch x64 create_sdk
	fi
}

src_install() {
		local instdir=/usr/$(get_libdir)/dart-sdk
		local bins="dart dartdevc dart2js dartdoc dartfmt pub dartanalyzer"
		insinto ${instdir}
		doins -r ${BUILD_DIR}/ReleaseX64/*
		for b in ${bins} ; do
        fperms 0775 ${instdir}/dart-sdk/bin/${b}
        dosym ${instdir}/dart-sdk/bin/${b} /usr/bin/${b}
    done
}
