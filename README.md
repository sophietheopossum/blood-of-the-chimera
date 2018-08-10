# prototype99
An unofficial Gentoo Overlay that enables installation of Canonical's "Snappy" backbone as well as other packages.

## Add the Overlay using layman
Gentoo's currently preferred Overlay system is through using a git sync.  What follows are abbreviated instructions assuming that you already have the `dev-vcs/git` and  `app-portage/layman` packages installed. (there are other methods, however layman allows you to keep your packages organised. Compare it to ubuntu's ppas if you must)

Add the overlay:

    # layman -o https://raw.githubusercontent.com/prototype99/prototype99/master/repositories.xml -f -a prototype99

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
2.31.1 installs correctly, however it does not function.
Based off of Docker being available within this portage category, I have placed snapd (the guts of snappy) here as well.  Installation of this package will draw in `sys-apps/snap-confine` as a dependency.

### `games-util/steam-launcher`
BROKEN
currently in development, an attempt to add a new use flag

### `kde-apps/dolphin`
BROKEN
currently in development, an attempt to patch in ability to run as admin through sudo until administrative access is properly implemented

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

### `www-client/firefox`
based off of the bobwya build, now uses the jit build option to improve performance.

## Installation

    # emerge -av app-emulation/snapd

## Post-installation

    # systemctl enable --now snapd.service
## FAQ
### why isn't there an option without systemd?
good question, with openrc being the more popular init system, you  would think it would be an available option. sadly this is not a mistake, snappy is designed in such a way that systemd is required. obviously much like funtoo has proven with their solution with gnome, it is theoretically possible. so possible in fact, that early ubuntu (which used upstart) even used a modified version of systemd to run snappy. however to this best of my knowledge there is no updated version of that, hence no openrc compatible ebuilds. feel free to contribute and make this otherwise however i have no interest myself in doing so (i personally use systemd).
