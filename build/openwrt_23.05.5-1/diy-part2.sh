#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

#pushd feeds/packages/lang
#rm -rf golang && svn co https://github.com/openwrt/packages/branches/openwrt-22.03/lang/golang
#popd
#PATCH="grep '=[ym]' $(LINUX_DIR)/.config.set | LC_ALL=C sort | $(MKHASH) md5 > $(LINUX_DIR)/.vermagic"
#VERMAGIC_PATCH='cp $(TOPDIR)/.vermagic $(LINUX_DIR)/.vermagic'


#sed -i 's/192.168.1.1/192.168.1.5/g' package/base-files/files/bin/config_generate
#sed -i 's/UTC/CST-8/g' package/base-files/files/bin/config_generate
#sed -i 's/%D %V %C/OpenWrt By Pencail/g' package/base-files/files/etc/openwrt_release
#sed -i 's/%C/By Pencail/g' package/base-files/files/etc/banner

#删除软件仓库中luci-app-adguardhome或者adguardhome的初始化脚本
#rm -f feeds/pencail/luci-app-adguardhome/root/etc/init.d/adguardhome
sed -i '/INSTALL_BIN/d' feeds/packages/net/adguardhome/Makefile
