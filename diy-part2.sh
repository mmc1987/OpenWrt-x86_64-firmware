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



# 更新和安装feeds
# 注意：feeds已经在工作流中更新和安装，这里只安装自定义的luci应用
# ./scripts/feeds update -f luci
# ./scripts/feeds install -p luci -f luci-app-zerotier
# ./scripts/feeds install -p luci -f luci-app-easytier

# 修复samba4的libcrypt依赖问题
if [ -f $GITHUB_WORKSPACE/add-libcrypt.config ]; then
    echo "添加libcrypt依赖配置..."
    cat $GITHUB_WORKSPACE/add-libcrypt.config >> .config
fi

# make defconfig

# # 克隆私有仓库
# if [ -d "Openwrt_etc" ]; then
#     rm -rf Openwrt_etc
# fi


if [ ! -d "files" ]; then
    mkdir files
fi

# 检查REPO_TOKEN是否设置
if [ -z "$REPO_TOKEN" ]; then
    echo "警告: REPO_TOKEN 未设置，跳过克隆私有仓库"
else
    if git clone "https://${REPO_TOKEN}@github.com/mmc1987/Openwrt_etc.git"; then
        cp -rv Openwrt_etc/backup-OpenWrt/* files/
        rm -rf Openwrt_etc
    else
        echo "错误: 克隆私有仓库失败"
        exit 1
    fi
fi
