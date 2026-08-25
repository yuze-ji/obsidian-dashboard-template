#!/bin/bash

# Obsidian Dashboard Template - GitHub推送脚本

echo "🚀 开始推送到GitHub..."
echo "=========================================="

# 检查是否在正确的目录
if [ ! -f "Homepage.md" ]; then
    echo "❌ 错误：请在项目根目录运行此脚本"
    exit 1
fi

# 检查git是否已安装
if ! command -v git &> /dev/null; then
    echo "❌ 错误：请先安装Git"
    exit 1
fi

# 检查是否已初始化git
if [ ! -d ".git" ]; then
    echo "📝 初始化Git仓库..."
    git init
    git add .
    git commit -m "初始化：Obsidian优雅仪表板模板"
fi

# 检查远程仓库
if ! git remote get-url origin &> /dev/null; then
    echo "📝 添加远程仓库..."
    git remote add origin https://github.com/yuze-ji/obsidian-dashboard-template.git
fi

# 推送到GitHub
echo "📤 推送到GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo "=========================================="
    echo "✅ 推送成功！"
    echo ""
    echo "📍 项目地址："
    echo "   https://github.com/yuze-ji/obsidian-dashboard-template"
    echo ""
    echo "🎉 你的Obsidian仪表板模板已成功分享到GitHub！"
else
    echo "=========================================="
    echo "❌ 推送失败"
    echo ""
    echo "💡 可能的原因："
    echo "   1. 网络连接问题"
    echo "   2. GitHub认证失败（需要个人访问令牌）"
    echo ""
    echo "📖 解决方案："
    echo "   - 使用GitHub个人访问令牌："
    echo "     https://github.com/settings/tokens"
    echo "   - 或配置SSH密钥："
    echo "     https://docs.github.com/en/authentication/connecting-to-github-with-ssh"
fi
