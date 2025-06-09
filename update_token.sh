#!/bin/bash

# 更新 GitHub token 的脚本
# 使用方法: ./update_token.sh <new_token>

if [ $# -eq 0 ]; then
    echo "使用方法: $0 <new_token>"
    echo "例如: $0 your_github_token_here"
    exit 1
fi

NEW_TOKEN=$1
REPO_URL="https://${NEW_TOKEN}@github.com/mmc1987/OpenWrt-x86_64-firmware.git"

echo "正在更新远程仓库 URL..."
git remote set-url origin "$REPO_URL"

echo "验证远程仓库配置..."
git remote -v

echo "测试连接..."
git fetch origin

echo "完成！现在您可以尝试推送代码了。"
echo "使用命令: git push --force-with-lease origin main" 