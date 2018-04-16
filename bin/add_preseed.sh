#!/bin/bash
#
# Auteur : Djezon HERBAUT
# Date de création : 12/04/2018
# Description : Ce script permet d'intégrer le fichier preseed.cfg dans l'archive initrd.
# Conditions préalables : 
#   - Etre root.
#   - Le fichier preseed.cfg doit etre dans le repertoire home de root
#   - Le fichier initrd.gz doit etre situe dans /var/lib/tftpboot/debian-installer/amd64/

cp -a /var/lib/tftpboot/debian-installer/amd64/initrd.gz /tmp/
gzip -dc /tmp/initrd.gz >/tmp/initrd.img
mkdir /tmp/work-initrd
cd /tmp/work-initrd
cpio -i < /tmp/initrd.img
cp ~/preseed.cfg ./
find . | cpio -H newc -o > /tmp/initrd.img
gzip -c /tmp/initrd.img >/tmp/initrd.gz
mv /tmp/initrd.gz /var/lib/tftpboot/debian-installer/amd64/
cd ..
rm -Rf /tmp/work-initrd
echo "Fait"
