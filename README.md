# prototype99
An unofficial Gentoo Overlay that enables installation of Canonical's "Snappy" backbone as well as other packages. if you use other overlays consider running first-install.sh or first-install-legacy.sh to add extra overlay specific configuration files as symlinks. profiles are designed to add to gentoo and keep repoman (a lil bit) happier. that being said, the main two profiles are default/linux/amd64/17.0/systemd (personal laptop) and default/linux/amd64/17.0/desktop/plasma/systemd (personal desktop). in the profiles preference is made for masking packages with no clear versioning and not using binaries as well as using python3_7 or pypy where possible. the profile mask handles old dependencies, binaries and bad versioning. the mask/* handles overlay specific stuff so the best ebuilds from each overlay are hopefully used. note that you may need to set dev-python/pypy low-memory and dev-util/cmake -system-jsoncpp in your package.use to avoid circular dependencies upon initial profile migration.

## Add the Overlay using layman
Gentoo's currently preferred Overlay system is through using a git sync.  What follows are abbreviated instructions assuming that you already have the `dev-vcs/git` and  `app-portage/layman` packages installed. (there are other methods, however layman allows you to keep your packages organised. Compare it to ubuntu's ppas if you must)

Add the overlay:

    # sudo layman -a prototype99

Sync overlay:

    # layman -S

## Add the Overlay Manually ##

Gentoo's currently preferred Overlay system is through using a git sync.  What follows are abbreviated instructions assuming that you already have the `dev-vcs/git` package installed. please note this is a more complex process that many may view as having no true benefit.

Next, create a custom `/etc/portage/repos.conf` entry for the **prototype99** overlay, so Portage knows what to do. Make sure that `/etc/portage/repos.conf` exists, and is a directory. Then, use your text editor without line wrapping:

    # nano -w /etc/portage/repos.conf/prototype99.conf

and put the following text in the file:

```
[gentoo-snappy]

# An unofficial overlay that supports the installation of the "Snappy" backbone.
# Maintainer: Seirra Blake (sophietheopossum@yandex.com)
# Upstream Maintainer: Clayton "kefnab" Dobbs (clayton.dobbs@gosecur.us)/Zygmunt "zyga" Krynicki (me@zygoon.pl)

location = /usr/local/portage/prototype99
sync-type = git
sync-uri = https://github.com/prototype99/prototype99.git
priority = 50
auto-sync = yes
```

Then run:

    # emaint sync --repo prototype99

## Packages
### `app-emulation/snapd`
BROKEN
2.31.1+ installs correctly, however it does not function. newer builds are thanks to https://github.com/JamesB192/JamesB192-overlay
Based off of Docker being available within this portage category, snapd is there as well.  Installation of older versions will draw in `sys-apps/snap-confine` as a dependency. post installation make sure to run the command `systemctl enable --now snapd.service`. note that you must have apparmor

### `app-admin/system-config-printer`
includes extra python3_7 compatibility

### `app-emulation/wine-staging`
Based off of the bobwya ebuild. Includes a patch to make the steam browser work without any extra effort on the user's end.

### `app-text/pdfsam`
ARCHIVED
work in progress. software that allows the manipulation of pdf files.

### `dev-lang/rust`

### `dev-libs/glib`
The GLib library of C routines

### `dev-libs/libcroco`
features a fixed dependency (gtk-doc pulls in gtk-doc-am and is also required it seems) and a more up to date homepage url

### `dev-libs/properties-cpp`
elementary overlay's ebuild with a build error fixed and some improvements in ebuild writing

### `dev-python/pycups`
ARCHIVED
includes extra python3_7 compatibility

### `dev-python/pyGPG`
includes extra python3_7 compatibility

### `dev-qt/qtnetwork`
ARCHIVED
fixed dependency version of the libressl ebuild. archived due to presence in upstream overlay

### `dev-qt/qtwayland`
includes a patch designed to remove an error

### `dev-vcs/gitkraken-bin`
WORK IN PROGRESS
gitkraken ebuild based off of the anomen and chaoslab overlay ebuilds. anomen is used as the base as it was closer to the layout of an official ebuild. added in from the chaoslab ebuild: newer copyright date, runtime dependencies, metadata.xml (with updated authors). personal edits: copied most up to date description from website, got rid of electron slot variable as it is unneeded.

### `games-simulation/firestorm-bin`
firestorm ebuilds with a functional url and better depends

### `games-util/steam-launcher`
ARCHIVED
an attempt to add a new use flag. development halted as steam for linux actually uses system libraries if they are newer.

### `gnome-base/librsvg`
includes optional gtk3 patch from ::gentoo, expands on ::gnome-next's depend designed to prevent incompatible rust-bin configurations, includes debug options from ::gnome

### `kde-apps/dolphin`
a modified version of the official ebuild with the ability to run as admin through sudo using the opensuse patch. This is supposedly less secure but functions closer to how a user would expect it to. credits to https://forum.kde.org/viewtopic.php?f=224&t=141836&start=30 for the patch in 18.08.3+. it also has an audiocd useflag enabling you to manage the dependencies for opening cds as a directory with a simple useflag.

### `kde-plasma/plasma-meta`
a modified version of the official ebuild with the ability to disable or enable powerdevil as needed with an aptly named use flag. on a desktop pc power management software does not always make sense. newer versions also have a minimal use flag to allow using the plasma-meta package for just certain components including the new kate and ksysguard related use flags.

### `mail-client/thunderbird`
based on the ::bobwya ebuild. contains some debian and mozilla/freebsd patches from ::pg-overlay, notably disabling some tests and adding more arm64 support (renamed to make more sense, all fixed in mozilla 61), based on use flags. also contains a patch to hide gtk2 behind nsplugin/NPAPI, the only thing that uses it.

### `media-gfx/inkscape`
doesn't depend on gtkspell because it gets removed from upstream inkscape

### `media-gfx/scour`
includes a patch designed to remove an error

### `media-libs/gexiv2`
ARCHIVED
includes extra python3_7 compatibility

### `media-libs/x264`
includes a patch to allow lto, credits to gentoolto

### `media-video/obs-studio`
includes a required dependency that is missing from the official ebuild.

### `net-libs/libtorrent-rasterbar`
includes extra python3_7 compatibility and more detailed dependencies

### `net-libs/nodejs`
fixed ssl configure logic, based off of ::chaoslab

### `net-libs/serf`
includes the ubuntu patch that adds openssl-1.1 compatibility

### `sci-geosciences/josm`
BROKEN
mirror of the rindeal ebuild, version is bumped.

### `sys-apps/kmod`
::libressl ebuild modified to only apply patch if you enable the use flag

### `sys-apps/snap-confine`
BROKEN
Provides sandbox type isolation of individual snap packages.  This is a dependency of `snapd` proper. Although newer versions seem to no longer require snap-confine due to a merge, it is still required for the older versions which i see no real reason to remove, gentoo is about choice after all, if you want an older version feel free.

### `sys-devel/binutils`
Has additional patch to fix problems with gold

### `sys-devel/llvm`
Built with gcc8 compatibility patches.
Low Level Virtual Machine (LLVM) is:
	1. A compilation strategy designed to enable effective program optimization across the entire lifetime of a program. LLVM supports effective optimization at compile time, link-time (particularly interprocedural), run-time and offline (i.e., after software is installed), while remaining transparent to developers and maintaining compatibility with existing build scripts.
	2. A virtual instruction set - LLVM is a low-level object code representation that uses simple RISC-like instructions, but provides rich, language-independent, type information and dataflow (SSA) information about operands. This combination enables sophisticated transformations on object code, while remaining light-weight enough to be attached to the executable. This combination is key to allowing link-time, run-time, and offline transformations.
	3. A compiler infrastructure - LLVM is also a collection of source code that implements the language and compilation strategy. The primary components of the LLVM infrastructure are a GCC-based C and C++ front-end, a link-time optimization framework with a growing set of global and interprocedural analyses and transformations, static back-ends for many popular (and some obscure) architectures, a back-end which emits portable C code, and a Just-In-Time compilers for several architectures.
4. LLVM does not imply things that you would expect from a high-level virtual machine. It does not require garbage collection or run-time code generation (In fact, LLVM makes a great static compiler!). Note that optional LLVM components can be used to build high-level virtual machines and other systems that need these services.

### `sys-devel/gcc`
Has additional clang use flag that adds the lld patch seen at https://gcc.gnu.org/ml/gcc-patches/2018-10/msg01240.html

### `sys-kernel/gentoo-sources`
older builds of gentoo sources. 4.16.0 is one of the few versions not to exhibit the following bug that affects certain btrfs systems without initramfs: https://bugzilla.kernel.org/show_bug.cgi?id=89721

### `virtual/linux-sources`
virtual package designed to accomodate almost all kernel ebuilds present in overlays

### `virtual/meta`
a large metapackage designed to aid in choosing the correct packages

### `virtual/wine`
virtual package modified to accomodate those who may want steam's proton to provide their wine

### `www-client/firefox`
firefox ebuild created using the bobwya and pg_overlay ebuilds. this ebuild contains various extra use flags and extra patches designed to improve performance and give greater choice. please refer to the readme.md kept with the ebuilds for more specific detail.

## FAQ
### why isn't there snapd without systemd?
good question, with openrc being the more popular init system, you  would think it would be an available option. sadly this is not a mistake, snappy is designed in such a way that systemd is required. obviously much like funtoo has proven with their solution with gnome, it is theoretically possible. so possible in fact, that early ubuntu (which used upstart) even used a modified version of systemd to run snappy. however to the best of my knowledge there is no updated version of that, hence no openrc compatible ebuilds. feel free to contribute and make this otherwise however i have no interest myself in doing so (i personally use systemd). that being said, elogind may or may not help
### why are there ebuilds without file extensions?
these are in production or archived, and thus not considered stable enough for real use.
### why are some of the listed packages lacking a description?
they have a readme in their directory
