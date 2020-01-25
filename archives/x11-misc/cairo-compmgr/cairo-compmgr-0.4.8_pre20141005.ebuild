# Lara Maia <dev@lara.click> 2014~2017
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 gnome2 autotools vala

MY_PN="Cairo-Composite-Manager"
EGIT_BRANCH="light"
EGIT_COMMIT="416ae1a6d04cc6da8de1bdfb4ec24b484e512a5d"
DESCRIPTION="Cairo based composite manager"
HOMEPAGE="http://cairo-compmgr.tuxfamily.org https://github.com/gandalfn/${MY_PN}"

EGIT_REPO_URI="https://github.com/gandalfn/${MY_PN}"
SRC_URI=""
KEYWORDS="~x86 ~amd64 ~x86-linux ~amd64-linux"


LICENSE="LGPL-3"
SLOT="0"

RDEPEND="x11-libs/gtk+:2
		 >=x11-libs/cairo-1.4
		 x11-libs/libSM
		 gnome-base/gconf"
DEPEND="${RDEPEND}
		 $(vala_depend)"

QA_PRESTRIPPED="
		usr/bin/ccm-schema-key-to-gconf
		usr/bin/cairo-compmgr"

pkg_setup() {
	G2CONF="$G2CONF --enable-gconf"
}

src_prepare() {
	sed "s/libvala-0.16/libvala-$(vala_best_api_version)/" -i configure.ac
	sed "s/libvala-0.16/libvala-$(vala_best_api_version)/" -i vapi/cairo-compmgr.deps

	gnome2_src_prepare
	vala_src_prepare
	eautoreconf
}

src_configure() {
	econf --prefix=/usr LIBS="-ldl -lgmodule-2.0 -lm -lz"
}
