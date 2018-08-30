# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1
JAVA_PKG_IUSE="doc"
inherit java-pkg-2 eutils

DESCRIPTION="A free open source tool to split and merge pdf documents"
HOMEPAGE="http://www.pdfsam.org/"
SRC_URI="https://github.com/torakiki/${PN}/archive/v${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="1.4"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/pdfsam"

COMMON_DEP="dev-java/dom4j:1
	dev-java/log4j
	dev-java/jaxen:1.1
	dev-java/bcprov
	dev-java/jgoodies-looks:2.0
	dev-java/maven-bin"
RDEPEND=">=virtual/jre-1.8
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.8
	sys-devel/gettext
	app-arch/unzip
	${COMMON_DEP}"

src_unpack() {
	unpack ${A} || die "unpack failed"
	mkdir "${S}"
	cd "${S}"
	java-pkg_jarfrom dom4j-1
	java-pkg_jarfrom log4j
	java-pkg_jarfrom jaxen-1.1
	java-pkg_jarfrom bcprov
	java-pkg_jarfrom jgoodies-looks-2.0
}
src_install() {
	insinto /usr/share/${PN}-${SLOT}/lib
	doins build/pdfsam-maine-br1/release/dist/pdfsam-enhanced/*.xml || die "config install failed"
	java-pkg_dojar build/pdfsam-maine-br1/release/dist/pdfsam-enhanced/pdfsam.jar
	java-pkg_dojar build/pdfsam-maine-br1/release/dist/pdfsam-enhanced/lib/pdfsam-*.jar
	java-pkg_dojar build/pdfsam-maine-br1/release/dist/pdfsam-enhanced/lib/emp4j.jar

	for plugins in decrypt encrypt merge unpack split setviewer cover mix rotate
	do
	    java-pkg_jarinto /usr/share/${PN}-${SLOT}/lib/plugins/${plugins}
	    insinto /usr/share/${PN}-${SLOT}/lib/plugins/${plugins}

	    java-pkg_dojar build/pdfsam-maine-br1/release/dist/pdfsam-enhanced/plugins/${plugins}/*.jar
	    doins build/pdfsam-maine-br1/release/dist/pdfsam-enhanced/plugins/${plugins}/*.xml || die "config install failed"
	done

	java-pkg_dolauncher ${PN}-${SLOT} --main org.pdfsam.guiclient.GuiClient --pwd "/usr/share/${PN}-${SLOT}/lib"
	java-pkg_dolauncher ${PN}-console-${SLOT} --main org.pdfsam.console.ConsoleClient --pwd "/usr/share/${PN}-${SLOT}/lib"

	newicon pdfsam-maine-br1/images/pdf.png pdfsam-${SLOT}.png
	make_desktop_entry ${PN} "PDF Split and Merge ${PV}" pdfsam-${SLOT}.png Office

	use doc && dodoc pdfsam-maine-br1/doc/enhanced/*

	use doc && java-pkg_dojavadoc build/pdfsam-maine-br1/apidocs
}
