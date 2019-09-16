#!/bin/bash
mkdir /etc/portage/package.mask/
sudo ln -sf /var/db/repos/prototype99/profiles-local/custom /etc/portage/package.mask/custom
sudo ln -sf /var/db/repos/prototype99/profiles-local/make.conf /etc/portage/make.conf
ln -sf /var/db/repos/prototype99/profiles-local/kitty.conf ~/.config/kitty/kitty.conf
