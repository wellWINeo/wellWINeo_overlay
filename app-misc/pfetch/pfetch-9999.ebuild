# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A pretty system information tool written in POSIX sh"
HOMEPAGE="https://github.com/dylanaraps/pfetch"
SRC_URI=""
EGIT_REPO_URI="https://github.com/dylanaraps/pfetch"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/make"

