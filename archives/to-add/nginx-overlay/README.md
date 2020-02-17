## nginx-overlay

This repository contains additional versions of gentoo's nginx ebuilds.

The ambition is to have a more thorough review and collaboration effort
in this repository before landing the final result in gentoo-x86. The easiest
way to collaborate is by reviewing/testing Pull Requests or submitting one
yourself.

Older ebuilds will use unstable (~) keywording while experimental ebuilds
lacks keywording. Please adjust your portage configuration accordingly.
Only bugfixes will be backported. If you're interested in newer 3rd-party
modules, consider moving to the latest development version.

If you choose to use this overlay as your preferred provider, please take note
that this repository might not follow gentoo's ebuild versioning conventions
(`-r1` or similar bumps). Keep track of the repository changelog and rebuild
if relevant.


### Usage

More recent versions of Portage allows you to add additional repositories by
adding a config file in `/etc/portage/repos.conf`. Here's an example:

```ini
[nginx-overlay]
location = /var/db/repos/nginx-overlay
sync-type = git
sync-uri = git://github.com/gentoo/nginx-overlay.git
auto-sync = yes
```

Keyword as appropriate and use emerge like you normally would do.


### Branch workflow

The **master** branch is always considered being production ready, which means
that all development should be made in branches. Fork the repository, create
a branch on your local git clone (or github account) and then create a Pull
Request to have it considered for inclusion.

All commits and merges to **master** should be signed off (`-s`) – unless you're
merging your own commit – and preferably signed (`-S`). Always keep
history when merging a branch (`--no-ff`).


### History

Nginx in Gentoo previously followed [upstream's conventions][1] regarding always
following latest version. This changed with 1.8 and 1.9 since we during the 1.7
cycle had issues with our wide range of third party modules that complicated
security-related version bumps. In order to make sure we always have a concept
of "stable", we will now use the stable branches as stable.


### Contributing

Contributions are welcome. Fork (preferably to a branch) and create a
pull request. Bugs to versions in the main gentoo tree should always be filed
in the [Gentoo Bugzilla][2].


[1]: http://nginx.com/blog/nginx-1-6-1-7-released/
[2]: http://bugs.gentoo.org
