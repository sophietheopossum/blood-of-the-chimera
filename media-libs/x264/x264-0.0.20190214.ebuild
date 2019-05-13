# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic multilib-minimal

DESCRIPTION="A free library for encoding X264/AVC streams"
HOMEPAGE="https://www.videolan.org/developers/x264.html"
MY_P="x264-snapshot-$(ver_cut 3)-2245"
SRC_URI="https://download.videolan.org/pub/videolan/x264/snapshots/${MY_P}.tar.bz2"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
S="${WORKDIR}/${MY_P}"

SLOT="0/157" # SONAME

LICENSE="GPL-2"
IUSE="+10bit altivec +interlaced lto opencl pic static-libs cpu_flags_x86_sse +threads"

ASM_DEP=">=dev-lang/nasm-2.13"
DEPEND="abi_x86_32? ( ${ASM_DEP} )
	abi_x86_64? ( ${ASM_DEP} )
	opencl? ( dev-lang/perl )"
RDEPEND="opencl? ( >=virtual/opencl-0-r3[${MULTILIB_USEDEP}] )
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-medialibs-20130224-r7
		!app-emulation/emul-linux-x86-medialibs[-abi_x86_32(-)] )"

DOCS="AUTHORS doc/*.txt"

src_prepare() {
lto && eapply "${FILESDIR}/lto.patch"
}

multilib_src_configure() {
	tc-export CC
	local asm_conf=""

	if [[ ${ABI} == x86* ]] && { use pic || use !cpu_flags_x86_sse ; } || [[ ${ABI} == "x32" ]] || [[ ${CHOST} == armv5* ]] || [[ ${ABI} == ppc* ]] && { use !altivec ; }; then
		asm_conf=" --disable-asm"
	fi

	"${S}/configure" \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--disable-cli \
		--disable-avs \
		--disable-lavf \
		--disable-swscale \
		--disable-ffms \
		--disable-gpac \
		--enable-pic \
		--enable-shared \
		--host="${CHOST}" \
		$(usex 10bit "" "--bit-depth=8") \
		$(usex interlaced "" "--disable-interlaced") \
		$(usex lto "--enable-lto" "") \
		$(usex opencl "" "--disable-opencl") \
		$(usex static-libs "--enable-static" "") \
		$(usex threads "" "--disable-thread") \
		${asm_conf} || die
}
