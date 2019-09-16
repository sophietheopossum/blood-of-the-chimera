#!/bin/bash
#run daily
cd /var/db/repos/prototype99/profiles-local
sudo curl https://api.gentoo.org/overlays/repositories.xml -o stage0.xml
cmp stage0.xml stage1.xml && exit || sudo cp stage0.xml stage1.xml
sudo rm stage0.xml
sudo cp stage1.xml stage2.xml
sudo patch stage2.xml repo.patch || printf "To: sophietheopossum@yandex.ru\nFrom: sophietheopossum@yandex.ru\nSubject: patch failed\n\npatch can't apply, try regenerating the patch" | msmtp sophietheopossum@yandex.ru && exit
printf "To: sophietheopossum@yandex.ru\nFrom: sophietheopossum@yandex.ru\nSubject: new repositories available\n\nrun\nsudo layman -f && sudo layman -a ALL\nto see them" | msmtp sophietheopossum@yandex.ru
