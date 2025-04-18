#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# echo 'src-git zerotier https://github.com/mwarning/zerotier-openwrt.git' >>feeds.conf.default

# git clone https://github.com/asvow/luci-app-tailscale feeds/luci/applications/luci-app-tailscale


./scripts/feeds update -a

# 克隆luci-app-zerotier
git clone --depth=1 https://github.com/mmc1987/luci-app-zerotier.git feeds/luci/applications/luci-app-zerotier

# 克隆luci-app-easytier
git clone --depth=1 https://github.com/EasyTier/luci-app-easytier.git feeds/luci/applications/luci-app-easytier
