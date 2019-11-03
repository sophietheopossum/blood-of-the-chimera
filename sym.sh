#!/bin/bash
sudo mkdir /etc/portage/package.mask/
sudo mkdir /etc/portage/make.conf/
sudo ln -sf /var/db/repos/prototype99/profiles-local/custom /etc/portage/package.mask/custom
sudo ln -sf /var/db/repos/prototype99/profiles-local/make.conf /etc/portage/make.conf/make.conf
sudo ln -sf /var/db/repos/prototype99/profiles-local/jemalloc.conf /etc/portage/make.conf/jemalloc.conf
ln -sf /var/db/repos/prototype99/profiles-local/kitty.conf ~/.config/kitty/kitty.conf
sudo ln -sf /var/db/repos/prototype99/profiles-local/genkernel.conf /etc/genkernel.conf
sudo ln -sf /var/db/repos/prototype99/profiles-local/env /etc/portage/env
sudo ln -sf /var/db/repos/prototype99/profiles-local/package.env /etc/portage/package.env
sudo ln -sf /var/db/repos/gentoo /var/db/repos/gentoo_prefix