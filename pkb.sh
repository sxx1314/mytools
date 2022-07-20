#!/usr/bin/env bash


# install dep
sudo apt update
sudo apt install -y wget
sudo apt build-dep -y linux
sudo apt install -y devscripts debhelper equivs git dwarves
wget http://ftp.us.debian.org/debian/pool/main/d/dwarves-dfsg/dwarves_1.20-1_amd64.deb
sudo dpkg -i ./dwarves_1.20-1_amd64.deb

git clone -b v5.18.x https://github.com/fabianishere/pve-edge-kernel
git clone -b v5.17.x https://github.com/sxx1314/pve-kernel.git
cp pve-kernel/5.18.x/config.pve pve-edge-kernel/debian/config/
cp pve-kernel/5.18.x/series.linux pve-edge-kernel/debian/patches/series.linux
cp pve-kernel/5.18.x/01000-net-fullcone-nat.patch pve-edge-kernel/debian/patches/ubuntu/
cd pve-edge-kernel

git submodule update --init --depth=1 --recursive linux
git submodule update --init --recursive

debian/rules debian/control
sudo mk-build-deps -i
debuild -ePVE* --jobs=auto -b -uc -us



cd ..
mkdir "artifact"
# 删除无用且巨大的调试包

mv ./*.deb artifact/
