# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
VIRTUALX_REQUIRED="pgo"
WANT_AUTOCONF="2.1"
MOZ_ESR=""

PYTHON_COMPAT=( python3_{5,6,7} )

# This list can be updated with scripts/get_langs.sh from the mozilla overlay
MOZ_LANGS=( "ach" "af" "an" "ar" "as" "ast" "az" "bg" "bn-BD" "bn-IN" "br" "bs" "ca" "cak" "cs" "cy" "da" "de" "dsb"
"el" "en" "en-GB" "en-US" "en-ZA" "eo" "es-AR" "es-CL" "es-ES" "es-MX" "et" "eu" "fa" "ff" "fi" "fr" "fy-NL" "ga-IE"
"gd" "gl" "gn" "gu-IN" "he" "hi-IN" "hr" "hsb" "hu" "hy-AM" "id" "is" "it" "ja" "ka" "kab" "kk" "km" "kn" "ko" "lij" "lt" "lv"
"mai" "mk" "ml" "mr" "ms" "nb-NO" "nl" "nn-NO" "or" "pa-IN" "pl" "pt-BR" "pt-PT" "rm" "ro" "ru" "si" "sk" "sl" "son" "sq"
"sr" "sv-SE" "ta" "te" "th" "tr" "uk" "uz" "vi" "xh" "zh-CN" "zh-TW" )

#used by mozlinguas
MOZ_HTTP_URI="https://archive.mozilla.org/pub/${PN}/releases"

# Mercurial repository for Mozilla Firefox patches to provide better KDE Integration (developed by Wolfgang Rosenauer for OpenSUSE)
EHG_REPO_URI="https://www.rosenauer.org/hg/mozilla"

inherit autotools check-reqs flag-o-matic gnome2-utils llvm  mozlinguas-v2 pax-utils toolchain-funcs xdg-utils \
	mercurial mozcoreconf-v6

DESCRIPTION="Firefox Web Browser, with SUSE patchset, to provide better KDE integration"
HOMEPAGE="https://www.mozilla.com/firefox
	https://www.rosenauer.org/hg/mozilla"

KEYWORDS="~amd64 ~x86"

SLOT="0"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
IUSE="accessibility alsa artifact bindist clang cups dbus debug egl eme-free ffmpeg gconf +gmp-autoupdate hardened hwaccel jack jemalloc jit kde neon pie privacy pulseaudio raw screenshot selinux startup-notification system-bz2 system-ffi system-graphite2 system-harfbuzz system-icu system-jpeg system-libevent system-libvpx system-nspr system-nss system-pixman system-png system-sqlite system-zlib test wifi wmf X"
RESTRICT="!bindist? ( bindist )"

# Patch version
PATCH_URIS=( https://dev.gentoo.org/~{anarchy,axs,polynomial-c}/mozilla/patchsets/${PN}-62.0-patches-01.tar.xz )
SRC_URI="${SRC_URI}
	${MOZ_HTTP_URI}/${MOZ_PV}/source/firefox-${MOZ_PV}.source.tar.xz
	${PATCH_URIS[@]}"

ASMGL_DEPEND=">=dev-lang/yasm-1.1
	virtual/opengl"
ELIBC=">=virtual/cargo-0.25.0
	>=virtual/rust-1.24.0"

CDEPEND="
	dev-libs/atk
	dev-libs/expat
	>=x11-libs/cairo-1.10[X]
	>=x11-libs/gtk+-2.18:2
	>=x11-libs/gtk+-3.4.0:3
	x11-libs/gdk-pixbuf
	>=x11-libs/pango-1.22.0
	>=media-libs/mesa-10.2:*
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	kernel_linux? ( !pulseaudio? ( media-libs/alsa-lib ) )
	virtual/freedesktop-icon-theme
	dbus? ( >=sys-apps/dbus-0.60
		>=dev-libs/dbus-glib-0.72 )
	startup-notification? ( >=x11-libs/startup-notification-0.8 )
	>=dev-libs/glib-2.26:2
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXt
	pulseaudio? ( || ( media-sound/pulseaudio
		>=media-sound/apulse-0.1.9 ) )
	system-ffi? ( >=virtual/libffi-3.0.10 )
	system-graphite2? ( >=media-gfx/graphite2-1.3.9-r1 )
	system-harfbuzz? ( >=media-libs/harfbuzz-1.4.2:0= )
	system-icu? ( >=dev-libs/icu-60.2:= )
	system-jpeg? ( >=media-libs/libjpeg-turbo-1.2.1 )
	system-libevent? ( >=dev-libs/libevent-2.0:0= )
	system-libvpx? ( >=media-libs/libvpx-1.5.0:0=[postproc] )
	system-nspr? ( >=dev-libs/nspr-4.19 )
	system-nss? ( >=dev-libs/nss-3.38 )
	system-pixman? ( >=x11-libs/pixman-0.19.2 )
	system-png? ( >=media-libs/libpng-1.6.34:0=[apng] )
	system-sqlite? ( >=dev-db/sqlite-3.24.0:3[secure-delete,debug=] )
	system-zlib? ( >=sys-libs/zlib-1.2.3 )
	wifi? ( kernel_linux? ( net-misc/networkmanager ) )
	jack? ( virtual/jack )
	selinux? ( sec-policy/selinux-mozilla )"

RDEPEND="${CDEPEND}
	kde? ( kde-misc/kmozillahelper:=  )"

DEPEND="${CDEPEND}
	app-arch/zip
	app-arch/unzip
	>=sys-devel/binutils-2.30
	sys-apps/findutils
	elibc_glibc? ( ${ELIBC} )
	elibc_musl? ( ${ELIBC} )
	clang? (
		>=sys-devel/llvm-4.0.1[gold]
		>=sys-devel/lld-4.0.1
	)
	amd64? ( ${ASMGL_DEPEND} )
	x86? ( ${ASMGL_DEPEND} )"
	
REQUIRED_USE="wifi? ( dbus )
?? ( alsa jack pulseaudio )"

S="${WORKDIR}/firefox-${PV%_*}"

QA_PRESTRIPPED="usr/lib*/${PN}/firefox"

BUILD_OBJ_DIR="${S}/ff"

# allow GMP_PLUGIN_LIST to be set in an eclass or
# overridden in the enviromnent (advanced hackers only)
if [[ -z $GMP_PLUGIN_LIST ]]; then
	GMP_PLUGIN_LIST=( gmp-gmpopenh264 gmp-widevinecdm )
fi

llvm_check_deps() {
	has_version "sys-devel/clang:${LLVM_SLOT}"
}

pkg_setup() {
	moz_pkgsetup

	# Avoid PGO profiling problems due to enviroment leakage
	# These should *always* be cleaned up anyway
	unset -v DBUS_SESSION_BUS_ADDRESS \
		DISPLAY \
		ORBIT_SOCKETDIR \
		SESSION_MANAGER \
		XDG_SESSION_COOKIE \
		XAUTHORITY

	if ! use bindist; then
		einfo
		elog "You are enabling official branding. You may not redistribute this build"
		elog "to any users on your network or the internet. Doing so puts yourself into"
		elog "a legal problem with Mozilla Foundation"
		elog "You can disable it by emerging ${PN} _with_ the bindist USE-flag"
	fi

	addpredict /proc/self/oom_score_adj

	llvm_pkg_setup
}

pkg_pretend() {
	# Ensure we have enough disk space to compile
	CHECKREQS_DISK_BUILD="4G"

	check-reqs_pkg_setup
}

src_unpack() {
	default

	# Unpack language packs
	mozlinguas_src_unpack
	if use kde; then
		if [[ ${MOZ_PV} =~ ^\(10|17|24\)\..*esr$ ]]; then
			EHG_REVISION="esr${MOZ_PV%%.*}"
		elif [[ ${MOZ_PV} =~ ^48\. ]]; then
			EHG_REVISION="4663386a04de"
		else
			EHG_REVISION="${PN}${MOZ_PV%%.*}"
		fi
		KDE_PATCHSET="${PN}-kde-patchset"
		EHG_CHECKOUT_DIR="${WORKDIR}/${KDE_PATCHSET}"
		mercurial_fetch "${EHG_REPO_URI}" "${KDE_PATCHSET}"
	fi
}

src_prepare() {
	# Allow user to apply any additional patches without modifying ebuild
	eapply_user
	
	# Default to gentoo patchset
	local PATCHES=( "${WORKDIR}/${PN}" )
	if use kde; then
		sed -i -e 's:@BINPATH@/defaults/pref/kde.js:@RESPATH@/browser/@PREF_DIR@/kde.js:' \
			"${EHG_CHECKOUT_DIR}/firefox-kde.patch" || die "sed failed"
		# Gecko/toolkit OpenSUSE KDE integration patchset
		PATCHES+=(
			"${EHG_CHECKOUT_DIR}/mozilla-kde.patch"
			"${EHG_CHECKOUT_DIR}/mozilla-nongnome-proxies.patch"
		)
		# Firefox OpenSUSE KDE integration patchset
		PATCHES+=(
			"${EHG_CHECKOUT_DIR}/${PN}-branded-icons.patch"
			"${EHG_CHECKOUT_DIR}/${PN}-kde.patch"
		)
		# Uncomment the next line to enable KDE support debugging (additional console output)...
		#PATCHES+=( "${FILESDIR}/${PN}-kde-debug.patch" )
		# Uncomment the following patch line to force Plasma/Qt file dialog for Firefox...
		#PATCHES+=( "${FILESDIR}/${PN}-force-qt-dialog.patch" )
		# ... _OR_ install the patch file as a User patch (/etc/portage/patches/www-client/firefox/)
		# ... _OR_ add to your user .xinitrc: "xprop -root -f KDE_FULL_SESSION 8s -set KDE_FULL_SESSION true"
	fi

	PATCHES+=(
		#pg-overlay patches
    		"${FILESDIR}/dont-build-image-gtests.patch"
		"${FILESDIR}/allow-js-preference-files-to-set-locked-prefs.patch"
		"${FILESDIR}/clang.patch"
		#bobwya patches
		"${FILESDIR}/gentoo-654316.patch"
	)
	#apply the patches
	eapply ${PATCHES}

	# Enable gnomebreakpad
	if use debug; then
		sed -i -e "s:GNOME_DISABLE_CRASH_DIALOG=1:GNOME_DISABLE_CRASH_DIALOG=0:g" \
			"${S}"/build/unix/run-mozilla.sh || die "sed failed!"
	fi

	# Drop -Wl,--as-needed related manipulation for ia64 as it causes ld segfaults, bug #582432
	if use ia64; then
		sed -i \
		-e '/^OS_LIBS += no_as_needed/d' \
		-e '/^OS_LIBS += as_needed/d' \
		"${S}"/widget/gtk/mozgtk/gtk2/moz.build \
		"${S}"/widget/gtk/mozgtk/gtk3/moz.build \
		|| die "sed failed to drop --as-needed for ia64"
	fi

	# Ensure that our plugins dir is enabled as default
	sed -i -e "s:/usr/lib/mozilla/plugins:/usr/lib/nsbrowser/plugins:" \
		"${S}"/xpcom/io/nsAppFileLocationProvider.cpp || die "sed failed to replace plugin path for 32bit!"
	sed -i -e "s:/usr/lib64/mozilla/plugins:/usr/lib64/nsbrowser/plugins:" \
		"${S}"/xpcom/io/nsAppFileLocationProvider.cpp || die "sed failed to replace plugin path for 64bit!"

	# Fix sandbox violations during make clean, bug 372817
	sed -e "s:\(/no-such-file\):${T}\1:g" \
		-i "${S}"/config/rules.mk \
		-i "${S}"/nsprpub/configure{.in,} \
		|| die "sed failed"

	# Don't exit with error when some libs are missing which we have in
	# system.
	sed '/^MOZ_PKG_FATAL_WARNINGS/s@= 1@= 0@' \
		-i "${S}"/browser/installer/Makefile.in || die "sed failed"

	# Don't error out when there's no files to be removed:
	sed 's@\(xargs rm\)$@\1 -f@' \
		-i "${S}"/toolkit/mozapps/installer/packager.mk || die "sed failed"

	# Keep codebase the same even if not using official branding
	sed '/^MOZ_DEV_EDITION=1/d' \
		-i "${S}"/browser/branding/aurora/configure.sh || die "sed failed"

	# Autotools configure is now called old-configure.in
	# This works because there is still a configure.in that happens to be for the
	# shell wrapper configure script
	eautoreconf old-configure.in

	# Must run autoconf in js/src
	cd "${S}"/js/src || die "cd failed"
	eautoconf old-configure.in
}

src_configure() {
	# Google API keys (see http://www.chromium.org/developers/how-tos/api-keys)
	# Note: These are for Gentoo Linux use ONLY. For your own distribution, please
	# get your own set of keys.
	_google_api_key=AIzaSyDEAOvatFo0eTgsV_ZlEzx0ObmepsMzfAc

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	#remnants of mozconfig_config imported
	if use clang && ! tc-is-clang ; then
		# Force clang
		einfo "Enforcing the use of clang due to USE=clang ..."
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		strip-unsupported-flags
	elif ! use clang && ! tc-is-gcc ; then
		# Force gcc
		einfo "Enforcing the use of gcc due to USE=-clang ..."
		CC=${CHOST}-gcc
		CXX=${CHOST}-g++
		strip-unsupported-flags
	fi
	
	# common config components
	mozconfig_use_with system-zlib
	mozconfig_use_with system-bz2
	
	# Must pass release in order to properly select linker
	mozconfig_annotate 'Enable by Gentoo' --enable-release
	
	# Avoid auto-magic on linker
	if use clang ; then
		# This is upstream's default
		mozconfig_annotate "forcing ld=lld due to USE=clang" --enable-linker=lld
	elif tc-ld-is-gold ; then
		mozconfig_annotate "linker is set to gold" --enable-linker=gold
	else
		mozconfig_annotate "linker is set to bfd" --enable-linker=bfd
	fi
	
	mozconfig_use_enable !bindist official-branding
	mozconfig_use_with bindist branding browser/branding/aurora
	mozconfig_use_enable pie
	mozconfig_use_enable debug
	mozconfig_use_enable debug dmd
	mozconfig_use_enable debug tests
	mozconfig_use_enable debug ipdl-tests
	mozconfig_use_enable debug debug-symbols
	mozconfig_use_enable debug crashreporter
	mozconfig_use_enable debug rust-debug
	mozconfig_use_enable debug rust-tests
	mozconfig_use_enable debug debug-js-modules
	mozconfig_use_enable debug logrefcnt
	mozconfig_use_enable debug address-sanitizer
	mozconfig_use_enable debug address-sanitizer-reporter
	mozconfig_use_enable debug memory-sanitizer
	mozconfig_use_enable debug dump-painting
	mozconfig_use_enable debug thread-sanitizer
	mozconfig_use_enable debug signed-overflow-sanitizer
	mozconfig_use_enable debug unsigned-overflow-sanitizer
	mozconfig_use_enable debug dtrace
	mozconfig_use_enable debug coverage
	mozconfig_use_enable debug gc-trace
	mozconfig_use_enable debug trace-logging
	mozconfig_use_enable debug fuzzing
	mozconfig_use_enable !debug install-strip
	mozconfig_use_enable startup-notification
	mozconfig_use_enable wifi necko-wifi
	mozconfig_use_enable dbus
	mozconfig_use_enable jit ion
	mozconfig_use_with system-nspr
	mozconfig_use_with system-nspr nspr-prefix "${SYSROOT}${EPREFIX}"/usr
	mozconfig_use_with system-nss
	mozconfig_use_with system-nss nss-prefix "${SYSROOT}${EPREFIX}"/usr
	mozconfig_annotate '' --x-includes="${SYSROOT}${EPREFIX}"/usr/include --x-libraries="${SYSROOT}${EPREFIX}"/usr/$(get_libdir)
	mozconfig_use_with system-libevent
	mozconfig_annotate '' --prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --libdir="${EPREFIX}"/usr/$(get_libdir)
	mozconfig_use_with system-png
	mozconfig_use_enable system-ffi
	mozconfig_use_enable gconf
	mozconfig_annotate '' --with-intl-api
	mozconfig_use_enable system-pixman
	mozconfig_use_enable jemalloc
	mozconfig_use_enable wmf
	mozconfig_use_enable raw
	mozconfig_use_enable cups printing
	mozconfig_use_enable ffmpeg
	mozconfig_use_enable jemalloc replace-malloc
	mozconfig_use_enable !privacy cookies
	mozconfig_annotate '' --disable-mortar
	mozconfig_annotate '' --enable-pipeline-operator
	mozconfig_annotate '' --enable-hardware-aec-ns
	mozconfig_annotate '' --enable-bundled-fonts
	mozconfig_use_with X x
	mozconfig_use_enable artifact artifact-builds
	if use artifact && use debug; then
		mozconfig_annotate '' --enable-artifact-build-symbols
	fi
	
	# skia has no support for big-endian platforms
	if [[ $(tc-endian) == "big" ]]; then
		mozconfig_annotate 'big endian target' --disable-skia
	else
		mozconfig_annotate '' --enable-skia
	fi
	
	# Instead of the standard --build= and --host=, mozilla uses --host instead
	# of --build, and --target intstead of --host.
	# Note, mozilla also has --build but it does not do what you think it does.
	# Set both --target and --host as mozilla uses python to guess values otherwise
	mozconfig_annotate '' --target="${CHOST}"
	mozconfig_annotate '' --host="${CBUILD:-${CHOST}}"
	
	mozconfig_annotate 'default toolkit' --enable-default-toolkit=cairo-gtk3
	
	# enable JACK, bug 600002
	mozconfig_use_enable jack
	mozconfig_use_enable pulseaudio
	mozconfig_use_enable alsa
	if ! use pulseaudio && ! use alsa && ! use jack; then
		einfo "Enable the alsa, jack or pulseaudio flag for audio"
	fi
	
	mozconfig_use_enable system-sqlite
	mozconfig_use_with system-jpeg
	mozconfig_use_with system-icu
	mozconfig_use_with system-libvpx
	mozconfig_use_with system-harfbuzz
	mozconfig_use_with system-graphite2
	
	if use clang ; then
		# https://bugzilla.mozilla.org/show_bug.cgi?id=1423822 fixed in firefox 63
		mozconfig_annotate 'elf-hack is broken when using Clang' --disable-elf-hack
	elif use arm ; then
		mozconfig_annotate 'elf-hack is broken on arm' --disable-elf-hack
	fi

	# Disable built-in ccache support to avoid sandbox violation, #665420
	# Use FEATURES=ccache instead!
	mozconfig_annotate '' --without-ccache
	sed -i -e 's/ccache_stats = None/return None/' \
		python/mozbuild/mozbuild/controller/building.py || \
		die "Failed to disable ccache stats call"
	
	# Enable/Disable eme support
	mozconfig_use_enable !eme-free eme
	
	mozconfig_use_enable accessibility
	mozconfig_annotate '' --disable-gtest-in-build
	mozconfig_annotate '' --disable-jprof
	mozconfig_annotate '' --disable-profiling
	mozconfig_annotate '' --disable-callgrind
	mozconfig_annotate '' --enable-rust-simd
	mozconfig_annotate '' --disable-vtune
	mozconfig_annotate '' --disable-instruments
	mozconfig_annotate '' --disable-perf
	mozconfig_annotate '' --disable-valgrind
	mozconfig_annotate '' --disable-verify-mar
	mozconfig_annotate '' --disable-updater
	mozconfig_annotate '' --disable-parental-controls
	mozconfig_annotate '' --disable-maintenance-service
	mozconfig_annotate '' --disable-mobile-optimize
	
	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	# Add full relro support for hardened
	if use hardened; then
		append-ldflags "-Wl,-z,relro,-z,now"
		mozconfig_use_enable hardened hardening
	fi

	# Modifications to better support ARM, bug 553364
	mozconfig_use_with neon fpu neon
	mozconfig_use_with neon thumb yes
	mozconfig_use_with neon thumb-interwork no
	if [[ ${CHOST} == armv* ]] ; then
		mozconfig_annotate '' --with-float-abi=hard
		if ! use system-libvpx ; then
			sed -i -e "s|softfp|hard|" \
				"${S}"/media/libvpx/moz.build
		fi
	fi

	# Setup api key for location services
	echo -n "${_google_api_key}" > "${S}"/google-api-key
	mozconfig_annotate '' --with-google-api-keyfile="${S}/google-api-key"

	mozconfig_annotate '' --enable-extensions="default"

	echo "mk_add_options MOZ_OBJDIR=${BUILD_OBJ_DIR}" >> "${S}/.mozconfig"
	echo "mk_add_options XARGS=/usr/bin/xargs" >> "${S}/.mozconfig"

	# Finalize and report settings
	mozconfig_final

	# workaround for funky/broken upstream configure...
	SHELL="${SHELL:-${EPREFIX}/bin/bash}" MOZ_NOSPAM=1 \
	./mach configure || die "mach configure failed"
}

src_compile() {
	MOZ_MAKE_FLAGS="${MAKEOPTS}" SHELL="${SHELL:-${EPREFIX}/bin/bash}" MOZ_NOSPAM=1 \
	./mach build --verbose || die "mach build failed"
}

src_install() {
	cd "${BUILD_OBJ_DIR}" || die "cd failed"

	# Pax mark xpcshell for hardened support, only used for startupcache creation.
	pax-mark m "${BUILD_OBJ_DIR}"/dist/bin/xpcshell

	# Add our default prefs for firefox
	local pkg_default_pref_dir="dist/bin/browser/defaults/preferences"
	cp "${FILESDIR}"/gentoo-default-prefs.js-1 \
		"${BUILD_OBJ_DIR}/${pkg_default_pref_dir}/all-gentoo.js" \
		|| die "cp failed"

	mozconfig_install_prefs \
		"${BUILD_OBJ_DIR}/${pkg_default_pref_dir}/all-gentoo.js"
    
  	# Add extra prefs designed to improve performance
  	cat "${FILESDIR}"/61.0.2-extra-prefs.js-1 >> \
	"${BUILD_OBJ_DIR}/${pkg_default_pref_dir}/all-gentoo.js" \
	|| die "cat failed"
	
	# set dictionary path, to use system hunspell
	echo "pref(\"spellchecker.dictionary_path\", \"${EPREFIX}/usr/share/myspell\");" \
		>>"${BUILD_OBJ_DIR}/dist/bin/browser/defaults/preferences/all-gentoo.js" || die

	# force the graphite pref if system-harfbuzz is enabled, since the pref cant disable it
	if use system-harfbuzz ; then
		echo "sticky_pref(\"gfx.font_rendering.graphite.enabled\",true);" \
			>>"${BUILD_OBJ_DIR}/dist/bin/browser/defaults/preferences/all-gentoo.js" || die
	fi

	# force cairo as the canvas renderer on platforms without skia support
	if [[ $(tc-endian) == "big" ]] ; then
		echo "sticky_pref(\"gfx.canvas.azure.backends\",\"cairo\");" \
			>>"${BUILD_OBJ_DIR}/dist/bin/browser/defaults/preferences/all-gentoo.js" || die
		echo "sticky_pref(\"gfx.content.azure.backends\",\"cairo\");" \
			>>"${BUILD_OBJ_DIR}/dist/bin/browser/defaults/preferences/all-gentoo.js" || die
	fi

	# Augment this with hwaccel prefs
	if use hwaccel; then
		cat "${FILESDIR}"/gentoo-hwaccel-prefs.js-1 >> \
		"${BUILD_OBJ_DIR}/${pkg_default_pref_dir}/all-gentoo.js" \
		|| die "cat failed"
	fi

	if ! use screenshot; then
		echo "pref(\"extensions.screenshots.disabled\", true);" >> \
			"${BUILD_OBJ_DIR}/${pkg_default_pref_dir}/all-gentoo.js" \
			|| die "echo failed"
	fi

	echo "pref(\"extensions.autoDisableScopes\", 3);" >> \
		"${BUILD_OBJ_DIR}/${pkg_default_pref_dir}/all-gentoo.js" \
		|| die "echo failed"

	if use kde; then
		# Add our kde prefs for firefox
		cp "${EHG_CHECKOUT_DIR}/MozillaFirefox/kde.js" \
			"${BUILD_OBJ_DIR}/${pkg_default_pref_dir}/kde.js" \
			|| die "cp failed"
	fi

	use gmp-autoupdate || use eme-free || for plugin in "${GMP_PLUGIN_LIST[@]}" ; do
		echo "pref(\"media.${plugin}.autoupdate\", false);" >> \
			"${BUILD_OBJ_DIR}/${pkg_default_pref_dir}/all-gentoo.js" \
			|| die "echo failed"
	done

	cd "${S}" || die "cd failed"
	MOZ_MAKE_FLAGS="${MAKEOPTS}" SHELL="${SHELL:-${EPREFIX}/bin/bash}" MOZ_NOSPAM=1 \
	DESTDIR="${D}" ./mach install

	# Install language packs
	MOZ_INSTALL_L10N_XPIFILE="1" mozlinguas_src_install

	local size sizes icon_path icon name
	if use bindist; then
		sizes="16 32 48"
		icon_path="${S}/browser/branding/aurora"
		# Firefox's new rapid release cycle means no more codenames
		# Let's just stick with this one...
		icon="aurora"
		name="Aurora"

		# Override preferences to set the MOZ_DEV_EDITION defaults, since we
		# don't define MOZ_DEV_EDITION to avoid profile debaucles.
		# (source: browser/app/profile/firefox.js)
		cat >>"${BUILD_OBJ_DIR}/${pkg_default_pref_dir}/all-gentoo.js" <<PROFILE_EOF
pref("app.feedback.baseURL", "https://input.mozilla.org/%LOCALE%/feedback/firefoxdev/%VERSION%/");
sticky_pref("lightweightThemes.selectedThemeID", "firefox-devedition@mozilla.org");
sticky_pref("browser.devedition.theme.enabled", true);
sticky_pref("devtools.theme", "dark");
PROFILE_EOF

	else
		sizes="16 22 24 32 48 64 128 256"
		icon_path="${S}/browser/branding/official"
		icon="${PN}"
		name="Mozilla Firefox"
	fi

	# Install icons and .desktop for menu entry
	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png"
	done
	# Install a 48x48 icon into /usr/share/pixmaps for legacy DEs
	newicon "${icon_path}/default48.png" "${icon}.png"
	newmenu "${FILESDIR}/icon/${PN}.desktop" "${PN}.desktop"
	sed -i -e "s:@NAME@:${name}:" -e "s:@ICON@:${icon}:" \
		"${ED}/usr/share/applications/${PN}.desktop" || die "sed failed"

	# Add StartupNotify=true bug 237317
	if use startup-notification; then
		echo "StartupNotify=true"\
			 >> "${ED}/usr/share/applications/${PN}.desktop" \
			|| die "echo failed"
	fi

	# Required in order to use plugins and even run firefox on hardened.
	pax-mark m "${ED}${MOZILLA_FIVE_HOME}"/{firefox,firefox-bin,plugin-container}
}

pkg_preinst() {
	gnome2_icon_savelist

	# if the apulse libs are available in MOZILLA_FIVE_HOME then apulse
	# doesn't need to be forced into the LD_LIBRARY_PATH
	if use pulseaudio && has_version ">=media-sound/apulse-0.1.9"; then
		einfo "APULSE found - Generating library symlinks for sound support"
		local lib
		pushd "${ED}${MOZILLA_FIVE_HOME}" &>/dev/null || die "pushd failed"
		for lib in ../apulse/libpulse{.so{,.0},-simple.so{,.0}} ; do
			# a quickpkg rolled by hand will grab symlinks as part of the package,
			# so we need to avoid creating them if they already exist.
			if ! [ -L ${lib##*/} ]; then
				ln -s "${lib}" ${lib##*/} || die "echo failed"
			fi
		done
		popd &>/dev/null || die "popd failed"
	fi
}

pkg_postinst() {
	# Update mimedb for the new .desktop file
	xdg_desktop_database_update
	gnome2_icon_cache_update

	if ! use gmp-autoupdate && ! use eme-free; then
		elog "USE='-gmp-autoupdate' has disabled the following plugins from updating or"
		elog "installing into new profiles:"
		local plugin
		for plugin in "${GMP_PLUGIN_LIST[@]}"; do elog "\\t ${plugin}" ; done
		elog
	fi

	if use pulseaudio && has_version ">=media-sound/apulse-0.1.9"; then
		elog "Apulse was detected at merge time on this system and so it will always be"
		elog "used for sound.  If you wish to use pulseaudio instead please unmerge"
		elog "media-sound/apulse."
		elog
	fi
}

pkg_postrm() {
	gnome2_icon_cache_update
}
