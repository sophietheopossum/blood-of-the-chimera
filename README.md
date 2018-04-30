# gentoo-snappy
An unofficial Gentoo Overlay that enables installation of Canonical's "Snappy" backbone.

## Add the Overlay using layman
Gentoo's currently preferred Overlay system is through using a git sync.  What follows are abbreviated instructions assuming that you already have the `dev-vcs/git` and  `app-portage/layman` packages installed. (there are other methods, however layman allows you to keep your packages organised. Compare it to ubuntu's ppas if you must)

Add the overlay:

    # layman -o https://raw.githubusercontent.com/gentoomaniac/gentoo-snappy/master/gentoo-snappy.xml -f -a gentoo-snappy

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
Based off of Docker being available within this portage category, I have placed snapd (the guts of snappy) here as well.  Installation of this package will draw in `sys-apps/snap-confine` as a dependency.

### `sys-apps/snap-confine`
Provides sandbox type isolation of individual snap packages.  This is a dependency of `snapd` proper. Although newer versions seem to no longer require snap-confine due to a merge, it is still required for the older versions which i see no real reason to remove, gentoo is about choice after all, if you want an older version feel free. 

## Installation

    # emerge -av app-emulation/snapd

## Post-installation

    # systemctl enable --now snapd.service
## FAQ
### why isn't there an option without systemd?
good question, with openrc being the more popular init system, you  would think it would be an available option. sadly this is not a mistake, snappy is designed in such a way that systemd is required. obviously much like funtoo has proven with their solution with gnome, it is theoretically possible. so possible in fact, that early ubuntu (which used upstart) even used a modified version of systemd to run snappy. however to this best of my knowledge there is no updated version of that, hence no openrc compatible ebuilds. feel free to contribute and make this otherwise.
