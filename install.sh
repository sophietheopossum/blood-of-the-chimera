#!/bin/bash
read -p "please go to https://www.gentoo.org/downloads/#other-arches and paste in the correct url: " URL
sudo curl ${URL} -o stage3.tar.bz2
sudo tar xpvf *.tar.bz2 --xattrs-include='*.*' --numeric-owner
echo "run rm -v -f stage3* or reserve the stage 3 file as a backup"
cd /var/db/repos
sudo mv /prototype99 /var/db/repos
git clone https://github.com/InBetweenNames/gentooLTO.git lto-overlay
mkdir --parents /mnt/gentoo/etc/portage/repos.conf
sudo cp /prototype99/profiles-local/repos.conf /mnt/gentoo/etc/portage/repos.conf/temp.conf
sudo mkdir /etc/portage/package.mask/
sudo ln -sf /var/db/repos/prototype99/profiles-local/custom /etc/portage/package.mask/custom
sudo ln -sf /var/db/repos/prototype99/profiles-local/make.conf /etc/portage/make.conf
cd ~
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/
sudo mount --types proc /proc /mnt/gentoo/proc
sudo mount --rbind /sys /mnt/gentoo/sys
sudo mount --make-rslave /mnt/gentoo/sys
sudo mount --rbind /dev /mnt/gentoo/dev
sudo mount --rbind /dev /mnt/gentoo/dev
sudo chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"
read -p "please enter your drive letter: " DR
sudo mount /dev/sd${DR}2 /boot
emerge --sync
eselect news read
eselect profile list
read -p "please enter the number of the profile you want: " ESELECT
sudo eselect profile set ${ESELECT}
emerge -1 dev-perl/XML-Parser
emerge @world
emerge -1 dev-libs/jemalloc
ln -sf /var/db/repos/prototype99/profiles-local/genkernel.conf /etc/genkernel.conf
ln -sf /var/db/repos/prototype99/profiles-local/kitty.conf ~/.config/kitty/kitty.conf
ln -sf /proc/self/mounts /etc/mtab
genkernel kernel
sudo eselect lcdfilter set custom