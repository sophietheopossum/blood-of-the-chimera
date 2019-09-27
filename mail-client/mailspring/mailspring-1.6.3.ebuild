# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Advanced email client"
HOMEPAGE="https://getmailspring.com"
SRC_URI="https://github.com/Foundry376/Mailspring/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="$WORKDIR/Mailspring-${PV}"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-nodejs/grunt"
RDEPEND="${DEPEND}"

src_compile() {
	grunt build || die
}
