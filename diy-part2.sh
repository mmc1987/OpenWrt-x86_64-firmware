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

# 设置错误时退出
set -e

# 日志函数
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# 错误处理函数
error_exit() {
    log "错误: $1"
    exit 1
}

# 检查目录是否存在
check_directory() {
    if [ ! -d "$1" ]; then
        error_exit "目录 $1 不存在"
    fi
}

# 创建目录（如果不存在）
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1" || error_exit "无法创建目录 $1"
        log "创建目录: $1"
    fi
}

log "开始执行 diy-part2.sh 脚本"

# 修改时区
log "修改系统时区为 Asia/Shanghai"
sed -i "s/set system\.\@system\[-1\]\.timezone='UTC'/set system\.\@system\[-1\]\.timezone='Asia\/Shanghai'/" package/base-files/files/bin/config_generate || error_exit "修改时区失败"

# 克隆私有仓库
log "开始克隆私有仓库"
if [ -d "Openwrt_etc" ]; then
    log "Openwrt_etc 目录已存在，正在删除"
    rm -rf Openwrt_etc
fi

# 使用 token 克隆私有仓库
if [ -z "$REPO_TOKEN" ]; then
    error_exit "未设置 REPO_TOKEN 环境变量"
fi

git clone "https://${REPO_TOKEN}@github.com/mmc1987/Openwrt_etc.git" || error_exit "克隆仓库失败"
log "私有仓库克隆完成"

# 检查源目录和目标目录
check_directory "Openwrt_etc/backup-OpenWrt"
create_directory "files"

# 复制文件
log "开始复制文件"
cp -rv Openwrt_etc/backup-OpenWrt/* files/ || error_exit "复制文件失败"
log "文件复制完成"

# 清理临时文件
log "清理临时文件"
rm -rf Openwrt_etc
log "清理完成"

log "diy-part2.sh 脚本执行完成"
