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
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default


#echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
#echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
#echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >>feeds.conf.default
#echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' >>feeds.conf.default
#echo 'src-git istore https://github.com/linkease/istore;main' >>feeds.conf.default

echo 'src-git kiddin9 https://github.com/kiddin9/openwrt-packages' >>feeds.conf.default


git clone --branch luci-21 https://github.com/jjm2473/luci-theme-argon.git package/luci-theme-argon
git clone --branch dev https://github.com/jjm2473/luci-app-argon-config.git package/luci-app-argon-config
 
