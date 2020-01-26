# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

XORG_BASE_INDIVIDUAL_URI=""
XORG_DRI="always"

inherit xorg-2 git-r3

if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="http://git.arm.linux.org.uk/cgit/xf86-video-armada.git"
	EGIT_BRANCH="unstable-devel"
	KEYWORDS=""
	DEPEND_COMMON="x11-libs/libetnaviv"
else
	SRC_URI="https://github.com/VCTLabs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~arm"
fi

DESCRIPTION="Xorg graphics driver for KMS based systems with pluggable GPU backend"
IUSE="-etnaviv"

RDEPEND=">=x11-base/xorg-server-1.18"

DEPEND="${RDEPEND}
	x11-libs/libdrm-armada
	${DEPEND_COMMON}
"

pkg_setup() {
	xorg-2_pkg_setup

	# note: vivante requires libGAL
	# and with-etnaviv-source is only on devel branch
	#--with-etnaviv-source="${S}"/etna_viv
	XORG_CONFIGURE_OPTIONS=(
		--disable-vivante
		$(use_enable etnaviv)
#		--with-etnaviv-source="${S}"/etna_viv
	)
}
