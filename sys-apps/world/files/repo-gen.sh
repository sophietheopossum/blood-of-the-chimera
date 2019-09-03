#!/bin/bash
#run daily
cd /var/db/repos/prototype99/profiles-local
sudo curl https://api.gentoo.org/overlays/repositories.xml -o stage0.xml
DUP="${diff -s stage0.xml stage1.xml}"
if ${DUP} = "Files stage0.xml and stage1.xml are identical" ; then
	sudo rm stageo.xml
	exit
fi
sudo cp stage0.xml stage1.xml
