# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( py{py,thon{2_7,3_{5,6,7}}} )
inherit distutils-r1

DESCRIPTION="Take an SVG file and produce a cleaner and more concise file"
HOMEPAGE="https://github.com/scour-project/scour"
SRC_URI="https://github.com/scour-project/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ppc ppc64 x86"
IUSE=""

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_test() {
	"${EPYTHON}" testscour.py -v || die "Tests fail with ${EPYTHON}"
}
