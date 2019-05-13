# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Virtual for Wine that supports multiple variants and slotting"

SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE="abi_x86_32 abi_x86_64 d3d9 proton staging"

RDEPEND="
	proton? ( games-util/steam-launcher )
	staging? ( || (
		app-emulation/wine-staging[staging]
		app-emulation/wine-any[staging]
	) )
	d3d9? ( || (
		app-emulation/wine-d3d9[d3d9]
		app-emulation/wine-any[d3d9]
	) )
	|| (
		app-emulation/wine-vanilla[abi_x86_32=,abi_x86_64=]
		app-emulation/wine-staging[abi_x86_32=,abi_x86_64=]
		app-emulation/wine-d3d9[abi_x86_32=,abi_x86_64=]
		app-emulation/wine-any[abi_x86_32=,abi_x86_64=]
	)
	!app-emulation/wine:0"
