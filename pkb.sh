#!/usr/bin/env bash

# 这一步用于从脚本同目录下的 config 文件中获取要编译的内核版本号
VERSION=$(grep 'Kernel Configuration' < config | awk '{print $3}')

# add deb-src to sources.list Ubuntu系统只需要把系统 apt 配置中的源码仓库注释取消掉即可
sed -i "/deb-src/s/# //g" /etc/apt/sources.list

# install dep
sudo apt update
sudo apt install -y wget
sudo apt build-dep -y linux
sudo apt install -y devscripts debhelper equivs git dwarves
wget http://ftp.us.debian.org/debian/pool/main/d/dwarves-dfsg/dwarves_1.20-1_amd64.deb
sudo apt install ./dwarves_1.20-1_amd64.deb

git clone -b v5.18.x https://github.com/fabianishere/pve-edge-kernel
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
