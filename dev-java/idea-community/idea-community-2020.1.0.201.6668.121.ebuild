# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"
inherit eutils versionator

SLOT="$(get_major_version)"
RDEPEND=">=virtual/jdk-1.8"

RESTRICT="strip mirror"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

DESCRIPTION="IntelliJ IDEA is an intelligent Java IDE"
HOMEPAGE="https://jetbrains.com/idea/"

SRC_URI="https://download.jetbrains.com/idea/ideaIC-$(get_version_component_range 1-2).tar.gz"

LICENSE="IntelliJ-IDEA"
IUSE="system-jre"
KEYWORDS="~x86 ~amd64"
MY_PV="$(get_version_component_range 4-5)"
SHORT_PV="$(get_version_component_range 1-2)"

S="${WORKDIR}/idea-IC-${MY_PV}"

src_unpack() {
	#mv ${WORKDIR}/idea-IC-* ${WORKDIR}/idea-IC-${MY_PV}
	local tar=(
		tar --extract

		--no-same-owner --no-same-permissions
		--strip-components=1 # otherwise we'd have to specify excludes as `${P}/path`

		--file="${archive}"
		--directory="${S}"
	)
	local _JBIJ_DEFAULT_TAR_EXCLUDE=(
		#'license' 'jbr/legal'
		# This plugin has several QA violations, eg. https://github.com/rindeal/gentoo-overlay/issues/67.
		# If someone needs it, it can be installed separately from JetBrains plugin repo.
		#'plugins/tfsIntegration'
		## arm
		'bin/fsnotifier-arm'
		## x86
		bin/{fsnotifier,libbreakgen.so,libyjpagent-linux.so}
	)
	local excludes=( "${_JBIJ_DEFAULT_TAR_EXCLUDE[@]}" )
	use system-jre && excludes+=( 'jre' )
	use amd64      || excludes+=( bin/{fsnotifier64,libbreakgen64.so,libyjpagent-linux64.so,LLDBFrontend} )
	local JBIJ_TAR_EXCLUDE=()
	use android || JBIJ_TAR_EXCLUDE+=( 'plugins/android' )
	use kotlin	|| JBIJ_TAR_EXCLUDE+=( 'plugins/Kotlin' )
	use spy-js	|| JBIJ_TAR_EXCLUDE+=( 'plugins/spy-js' )
	use svn		|| JBIJ_TAR_EXCLUDE+=( 'plugins/svn4idea' )
	use groovy	|| JBIJ_TAR_EXCLUDE+=( 'plugins/Groovy' )
	excludes+=( "${JBIJ_TAR_EXCLUDE[@]}" )
	tar+=( "${excludes[@]/#/--exclude=}" )
	"${tar[@]}" || die
}

src_prepare() {
	epatch ${FILESDIR}/idea-${SLOT}.sh.patch || die
}

src_install() {
	local dir="/opt/${P}"
	local exe="idea-${SLOT}"

	newconfd "${FILESDIR}/config-${SLOT}" idea-${SLOT}

	# config files
	insinto "/etc/idea"

	mv bin/idea.properties bin/idea-${SLOT}.properties
	doins bin/idea-${SLOT}.properties
	rm bin/idea-${SLOT}.properties

	case $ARCH in
		amd64|ppc64)
			cat bin/idea64.vmoptions > bin/idea.vmoptions
			rm bin/idea64.vmoptions
			;;
	esac

	mv bin/idea.vmoptions bin/idea-${SLOT}.vmoptions
	doins bin/idea-${SLOT}.vmoptions
	rm bin/idea-${SLOT}.vmoptions

	ln -s /etc/idea/idea-${SLOT}.properties bin/idea.properties

	rm -rf plugins/tfsIntegration/lib/native/linux/ppc
	rm -rf plugins/tfsIntegration/lib/native/solaris

	# idea itself
	insinto "${dir}"
	doins -r *

	fperms 755 "${dir}/bin/idea.sh"
	fperms 755 "${dir}/bin/fsnotifier"
	fperms 755 "${dir}/bin/fsnotifier64"

	newicon "bin/idea.png" "${exe}.png"
	make_wrapper "${exe}" "/opt/${P}/bin/idea.sh"
	make_desktop_entry ${exe} "IntelliJ IDEA ${SHORT_PV}" "${exe}" "Development;IDE"

	# Protect idea conf on upgrade
	env_file="${T}/25idea-${SLOT}"
	echo "CONFIG_PROTECT=\"\${CONFIG_PROTECT} /etc/idea/conf\"" > "${env_file}"  || die
	doenvd "${env_file}"
}
