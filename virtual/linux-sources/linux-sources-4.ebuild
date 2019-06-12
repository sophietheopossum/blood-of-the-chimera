# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info

DESCRIPTION="Virtual for Linux kernel sources"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="amd firmware +gentoo-sources intel +systemd threads-4 threads-16 +uefi"

RDEPEND="
	firmware? ( sys-kernel/linux-firmware )
	gentoo-sources? ( sys-kernel/gentoo-sources )
	!gentoo-sources? ( || (
		sys-kernel/sabayon-sources
		sys-kernel/odroid-sources
		sys-kernel/e-sources
		sys-kernel/pentoo-sources
		sys-kernel/backbone-sources
		sys-kernel/calculate-sources
		sys-kernel/bliss-kernel
		sys-kernel/vanilla-sources
		sys-kernel/ck-sources
		sys-kernel/git-sources
		sys-kernel/hardened-sources
		sys-kernel/minipli-sources
		sys-kernel/lh-sources
		sys-kernel/mips-sources
		sys-kernel/chromeos-sources
		sys-kernel/pf-sources
		sys-kernel/rt-sources
		sys-kernel/vserver-sources
		sys-kernel/xbox-sources
		sys-kernel/zen-sources
		sys-kernel/aufs-sources
		sys-kernel/raspberrypi-sources
		sys-kernel/reiser4-sources
		sys-kernel/adafruit-raspberrypi-sources
		sys-kernel/drm-raspberrypi-sources
		sys-kernel/nouveau-sources
		sys-kernel/bone-sources
	) )"

pkg_setup() {
	CONFIG_CHECK="MICROCODE MSDOS_PARTITION PROCESSOR_SELECT !CPU_SUP_CENTAUR !I8K"
	if use gentoo-sources; then
		CONFIG_CHECK="GENTOO_LINUX GENTOO_LINUX_PORTAGE"
		use systemd && CONFIG_CHECK="GENTOO_LINUX_INIT_SYSTEMD !GENTOO_LINUX_INIT_SCRIPT"
	fi
		if use threads-4; then
		CONFIG_CHECK="~!NR_CPUS"
		ERROR_NR_CPUS="can't read NR_CPUS, please check it's set to 4"
	fi
		if use threads-16; then
		CONFIG_CHECK="~!NR_CPUS"
		ERROR_NR_CPUS="can't read NR_CPUS, please check it's set to 16"
	fi
	use amd && CONFIG_CHECK="CPU_SUP_AMD MICROCODE_AMD !CPU_SUP_INTEL !MICROCODE_INTEL"
	use intel && CONFIG_CHECK="CPU_SUP_INTEL MICROCODE_INTEL !CPU_SUP_AMD !MICROCODE_AMD"
	use uefi && CONFIG_CHECK="EFI EFI_PARTITION PARTITION_ADVANCED"
}
