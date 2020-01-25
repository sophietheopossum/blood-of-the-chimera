# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

EGIT_COMMIT="4b494731710fd7d9b8223ce6d4c297e81004d04a"
EGIT_REPO_URI="https://github.com/domichel/${PN}"

DESCRIPTION="xdg application menu with full support for the additional categories for fvwm and other xdg compliant desktops"
HOMEPAGE="${EGIT_REPO_URI}"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""