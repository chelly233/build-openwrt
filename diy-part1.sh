#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#Add install program
git clone -b install --single-branch https://github.com/chelly233/build-openwrt-for-n1 package/install-program
#Add package autocore
sed -i 's/TARGET_bcm27xx/TARGET_bcm27xx||TARGET_armvirt/g' package/lean/autocore/Makefile
#Remove unwanted firmware
sed -i '/FEATURES+=/ { s/cpiogz //; s/ext4 //; s/ramdisk //; s/squashfs //; }' \
    target/linux/armvirt/Makefile
#Add package
packages=" \
brcmfmac-firmware-43430-sdio brcmfmac-firmware-43455-sdio kmod-brcmfmac wpad \
kmod-fs-ext4 kmod-fs-vfat kmod-fs-exfat dosfstools e2fsprogs ntfs-3g \
kmod-usb2 kmod-usb3 kmod-usb-storage kmod-usb-storage-extras kmod-usb-storage-uas \
blkid lsblk parted fdisk cfdisk losetup resize2fs tune2fs pv unzip tar getopt\
lscpu htop iperf3 curl lm-sensors install-program autocore
"
#Remove packages
rm -rf package/feeds/packages/coremark
rm -rf package/ctcgfw/luci-app-adguardhome
rm -rf package/ntlf9t/AdGuardHome

#copy packages
cp -fpR ${GITHUB_WORKSPACE}/packages/. package/diy/
