# prototype99
An unofficial Gentoo Overlay that enables installation of Canonical's "Snappy" backbone as well as other packages.

## Add the Overlay using layman
Gentoo's currently preferred Overlay system is through using a git sync.  What follows are abbreviated instructions assuming that you already have the `dev-vcs/git` and  `app-portage/layman` packages installed. (there are other methods, however layman allows you to keep your packages organised. Compare it to ubuntu's ppas if you must)

Add the overlay:

    # sudo layman -a prototype99

Sync overlay:

    # layman -S

## Add the Overlay Manually ##

Gentoo's currently preferred Overlay system is through using a git sync.  What follows are abbreviated instructions assuming that you already have the `dev-vcs/git` package installed. please note this is a more complex process that many may view as having no true benefit.

Next, create a custom `/etc/portage/repos.conf` entry for the **gentoo-snappy** overlay, so Portage knows what to do. Make sure that `/etc/portage/repos.conf` exists, and is a directory. Then, use your text editor without line wrapping:

    # nano -w /etc/portage/repos.conf/gentoo-snappy.conf

and put the following text in the file:

```
[gentoo-snappy]
 
# An unofficial overlay that supports the installation of the "Snappy" backbone.
# Maintainer: Clayton "kefnab" Dobbs (clayton.dobbs@gosecur.us)
# Upstream Maintainer: Zygmunt "zyga" Krynicki (me@zygoon.pl)
 
location = /usr/local/portage/gentoo-snappy
sync-type = git
sync-uri = https://github.com/zyga/gentoo-snappy.git
priority = 50
auto-sync = yes
```

Then run:

    # emaint sync --repo gentoo-snappy

## Packages
### `app-emulation/snapd`
BROKEN
2.31.1+ installs correctly, however it does not function. newer builds are thanks to https://github.com/JamesB192/JamesB192-overlay
Based off of Docker being available within this portage category, snapd is there as well.  Installation of older versions will draw in `sys-apps/snap-confine` as a dependency. post installation make sure to run the command `systemctl enable --now snapd.service`

### `app-text/pdfsam`
BROKEN
work in progress. software that allows the manipulation of pdf files.

### `app-emulation/wine-staging`
Based off of the bobwya ebuild. Includes a patch to make the steam browser work without any extra effort on the user's end.

### `dev-libs/glib`
The GLib library of C routines

### `dev-vcs/gitkraken-bin`
WORK IN PROGRESS
gitkraken ebuild based off of the anomen and chaoslab overlay ebuilds. anomen is used as the base as it was closer to the layout of an official ebuild. added in from the chaoslab ebuild: newer copyright date, runtime dependencies, metadata.xml (with updated authors). personal edits: copied most up to date description from website, got rid of electron slot variable as it is unneeded.

### `games-util/steam-launcher`
BROKEN
currently in development, an attempt to add a new use flag

### `kde-apps/dolphin`
a modified version of the official ebuild with the ability to run as admin through sudo using the opensuse patch. This is supposedly less secure but functions closer to how a user would expect it to.

### `media-video/obs-studio`
includes a required dependency that is missing from the official ebuild.

### `sci-geosciences/josm`
mirror of the rindeal ebuild, version is bumped.

### `sys-apps/snap-confine`
BROKEN
Provides sandbox type isolation of individual snap packages.  This is a dependency of `snapd` proper. Although newer versions seem to no longer require snap-confine due to a merge, it is still required for the older versions which i see no real reason to remove, gentoo is about choice after all, if you want an older version feel free. 

### `sys-devel/llvm`
Built with gcc8 compatibility patches.
Low Level Virtual Machine (LLVM) is:
	1. A compilation strategy designed to enable effective program optimization across the entire lifetime of a program. LLVM supports effective optimization at compile time, link-time (particularly interprocedural), run-time and offline (i.e., after software is installed), while remaining transparent to developers and maintaining compatibility with existing build scripts.
	2. A virtual instruction set - LLVM is a low-level object code representation that uses simple RISC-like instructions, but provides rich, language-independent, type information and dataflow (SSA) information about operands. This combination enables sophisticated transformations on object code, while remaining light-weight enough to be attached to the executable. This combination is key to allowing link-time, run-time, and offline transformations.
	3. A compiler infrastructure - LLVM is also a collection of source code that implements the language and compilation strategy. The primary components of the LLVM infrastructure are a GCC-based C and C++ front-end, a link-time optimization framework with a growing set of global and interprocedural analyses and transformations, static back-ends for many popular (and some obscure) architectures, a back-end which emits portable C code, and a Just-In-Time compilers for several architectures.
4. LLVM does not imply things that you would expect from a high-level virtual machine. It does not require garbage collection or run-time code generation (In fact, LLVM makes a great static compiler!). Note that optional LLVM components can be used to build high-level virtual machines and other systems that need these services.


### `sys-kernel/gentoo-sources`
older builds of gentoo sources. 4.16.0 is one of the few versions not to exhibit the following bug that affects certain btrfs systems without initramfs: https://bugzilla.kernel.org/show_bug.cgi?id=89721

### `www-client/firefox`
firefox ebuild created using the bobwya and pg_overlay ebuilds. this ebuild contains various extra use flags and extra patches designed to improve performance and give greater choice. from bobwya: base ebuild. from pg_overlay: JIT use flag (improves performance), python compatibility, various fedora and debian patches, dbus use flag, debug use flag, clang use flag, neon use flag, pulseaudio use flag, startup notification use flag, system library use flags, wifi use flag, CDEPEND values, patch series concept. extra edits: more prefs set to improve performance, removed mercurial code because it appears to fetch a blank repository.

## FAQ
### why isn't there snapd without systemd?
good question, with openrc being the more popular init system, you  would think it would be an available option. sadly this is not a mistake, snappy is designed in such a way that systemd is required. obviously much like funtoo has proven with their solution with gnome, it is theoretically possible. so possible in fact, that early ubuntu (which used upstart) even used a modified version of systemd to run snappy. however to this best of my knowledge there is no updated version of that, hence no openrc compatible ebuilds. feel free to contribute and make this otherwise however i have no interest myself in doing so (i personally use systemd).
### why are there ebuilds without file extensions?
these are in production, and thus not considered stable enough for real use.
