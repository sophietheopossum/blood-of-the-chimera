# prototype99
An unofficial Gentoo Overlay that enables installation of Canonical's "Snappy" backbone. I have chosen to rename this fork as i may choose to add additional packages over time. This way I need only submit one overlay which will help prevent layman from becoming overly cluttered.

## Add the Overlay
Gentoo's currently preferred Overlay system is through using a git sync.  What follows are abbreviated instructions assuming that you already have the `dev-vcs/git` and  `app-portage/layman` packages installed. (there are other methods, however layman allows you to keep your packages organised. Compare it to ubuntu's ppas if you must)

Add the overlay:

    # layman -o https://raw.githubusercontent.com/prototype99/prototype99/master/repositories.xml -f -a prototype99

Sync overlay:

    # layman -S

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
good question, with openrc being the more popular init system, you  would think it would be an available option. sadly this is not a mistake, snappy is designed in such a way that systemd is required. obviously much like funtoo has proven with their solution with gnome, it is theoretically possible. so possible in fact, that early ubuntu (which used upstart) even used a modified version of systemd to run snappy. however to this best of my knowledge there is no updated version of that, hence no openrc compatible ebuilds. feel free to contribute and make this otherwise however i have no interest myself in doing so (i personally use systemd).
