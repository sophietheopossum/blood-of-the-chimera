# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Meta file to pull in packages to help keep the world file clean"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="+composite dev +fat fslint +index +network-tray overlay spreadsheet +sudo +task-manager text-editor +xfs"

REQUIRED_USE=""

RDEPEND="
	composite? ( x11-misc/compton )
	dev? ( app-portage/repoman )
	fat? ( sys-fs/dosfstools )
	fslint? ( app-misc/fslint )
	index? ( sys-apps/mlocate )
	network-tray? ( gnome-extra/nm-applet )
	overlay? ( app-portage/layman )
	spreadsheet? ( app-office/gnumeric )
	sudo? ( app-admin/sudo )
	task-manager? ( kde-plasma/plasma-meta[task-manager] )
	text-editor? ( kde-plasma/plasma-meta[text-editor] )
	xfs? ( sys-fs/xfsprogs )
	virtual/linux-sources[fat?]
"
