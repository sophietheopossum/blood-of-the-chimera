# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Patch repository list "
HOMEPAGE="https://prototype99.github.io"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	newbin ${FILESDIR}/repo-gen.sh ${PN}
}
