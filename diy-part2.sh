#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# 修改时区
sed -i "s/set system\.\@system\[-1\]\.timezone='UTC'/set system\.\@system\[-1\]\.timezone='Asia\/Shanghai'/" package/base-files/files/bin/config_generate

# 克隆luci-app-zerotier
git clone --depth=1 https://github.com/mmc1987/luci-app-zerotier.git feeds/luci/applications/luci-app-zerotier

# 克隆luci-app-easytier
git clone --depth=1 https://github.com/EasyTier/luci-app-easytier.git feeds/luci/applications/luci-app-easytier

# 更新和安装feeds
./scripts/feeds update -f luci
./scripts/feeds install -p luci -f luci-app-zerotier
./scripts/feeds install -p luci -f luci-app-easytier
make defconfig

# 克隆私有仓库
if [ -d "Openwrt_etc" ]; then
    rm -rf Openwrt_etc
fi

git clone "https://${REPO_TOKEN}@github.com/mmc1987/Openwrt_etc.git"
cp -rv Openwrt_etc/backup-OpenWrt/* files/
rm -rf Openwrt_etc
