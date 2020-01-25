# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Meta file to pull in packages to help keep the world file clean"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+composite +fat +index +xfs"

REQUIRED_USE=""

RDEPEND="
	composite? ( x11-misc/compton )
	fat? ( sys-fs/dosfstools )
	index? ( sys-apps/mlocate )
	xfs? ( sys-fs/xfsprogs )
	virtual/linux-sources[fat?]
"
