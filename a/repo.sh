#!/bin/bash
apt install apache2 rsync dpkg-dev net-tools
clear
read -p "       MASUKAN NAMA ISO-V  ==> " nama;
read -p "       MASUKAN NAMA DVD-1  ==> " dvd1;
read -p "       MASUKAN NAMA DVD-2  ==> " dvd2;
read -p "       MASUKAN NAMA DVD-3  ==> " dvd3;


mkdir /repo 
mkdir /media/dvd1
mkdir /media/dvd2
mkdir /media/dvd3
mkdir -p /repo/dists/$nama/main/binary-amd64/
mkdir -p /repo/dists/$nama/main/source/

mount -o loop dvd/$dvd1 /media/dvd1
mount -o loop dvd/$dvd2 /media/dvd2
mount -o loop dvd/$dvd3 /media/dvd3

rsync -avH /media/dvd1/pool /repo/pool
rsync -avH /media/dvd2/pool /repo/pool
rsync -avH /media/dvd3/pool /repo/pool

cd /repo

dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz
dpkg-scansources . /dev/null | gzip -9c > Sources.gz

mv Packages.gz /repo/dists/$nama/main/binary-amd64/
mv Sources.gz /repo/dists/$nama/main/source/

mkdir /var/www/html/debian

ln -s /repo /var/www/html/debian

clear
ifconfig

read -p "       SILAHKAN INPUTKAN IP ANDA ==> " ip;
echo 'deb [trusted=yes] http://'$ip'/debian/repo/ '$nama' main' >> /etc/apt/sources.list
apt update && apt upgrade 
