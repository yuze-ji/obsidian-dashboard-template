# 📤 推送到GitHub详细说明

## 当前状态

✅ 模板文件已准备好
✅ Git仓库已初始化
✅ 远程仓库已配置

❌ 尚未推送到GitHub（需要你的GitHub认证）

## 🔐 第一步：获取GitHub认证

### 方式A：使用个人访问令牌（推荐）

1. 访问 https://github.com/settings/tokens
2. 点击 "Generate new token" → "Generate new token (classic)"
3. 设置：
   - Token name: `obsidian-dashboard-push`
   - Expiration: 90 days（或根据需要）
   - 勾选 `repo` 权限
4. 点击 "Generate token"
5. 复制生成的令牌（只显示一次！）

### 方式B：配置SSH密钥

1. 生成SSH密钥：
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

2. 添加到GitHub：https://github.com/settings/ssh/new

3. 修改远程URL为SSH格式：
```bash
git remote set-url origin git@github.com:yuze-ji/obsidian-dashboard-template.git
```

## 🚀 第二步：推送模板

### 方式1️⃣：使用自动脚本（最简单）

```bash
# 1. 进入项目目录
cd /path/to/obsidian-dashboard-template

# 2. 运行推送脚本
chmod +x push-to-github.sh
./push-to-github.sh

# 输入GitHub用户名和个人访问令牌（HTTPS方式）
```

### 方式2️⃣：手动推送（HTTPS）

```bash
cd /path/to/obsidian-dashboard-template
git push -u origin main
```

系统会提示输入：
- Username: `yuze-ji`
- Password: 粘贴你的个人访问令牌

### 方式3️⃣：手动推送（SSH）

```bash
cd /path/to/obsidian-dashboard-template
git push -u origin main
```

（无需输入密码，使用SSH密钥认证）

## ✅ 验证推送成功

推送完成后，打开GitHub查看：
```
https://github.com/yuze-ji/obsidian-dashboard-template
```

应该看到以下文件：
- ✅ Homepage.md
- ✅ README.md
- ✅ QUICK_START.md
- ✅ Project_List_Example.md
- ✅ .gitignore
- ✅ LICENSE
- ✅ GITHUB_PUSH.md

## 🔄 后续更新

如果后续修改了模板，推送更新：

```bash
cd /path/to/obsidian-dashboard-template
git add .
git commit -m "你的改动描述"
git push
```

## 📝 本地测试推送命令

如果你想先测试，可以在本地运行：

```bash
# 查看git状态
cd /tmp/obsidian-dashboard-template
git status

# 查看已提交的文件
git log --oneline

# 查看远程配置
git remote -v
```

## 🆘 故障排除

### 问题：认证失败

**HTTPS 令牌过期：**
```bash
git remote set-url origin https://新令牌@github.com/yuze-ji/obsidian-dashboard-template.git
git push
```

**SSH 密钥问题：**
```bash
ssh -T git@github.com
# 应显示：Hi yuze-ji! You've successfully authenticated...
```

### 问题：远程URL错误

```bash
# 查看当前URL
git remote -v

# 修改URL
git remote set-url origin https://github.com/yuze-ji/obsidian-dashboard-template.git
```

### 问题：本地文件冲突

```bash
# 检查哪些文件修改了
git status

# 重置到上次提交
git reset --hard HEAD
```

## 💡 安全提示

- ✅ 个人访问令牌仅在推送时使用
- ✅ 令牌过期后自动失效
- ✅ SSH密钥更安全（推荐长期使用）
- ❌ 不要将令牌上传到仓库
- ❌ 不要在终端历史中泄露令牌

## 📚 更多帮助

- GitHub官方文档：https://docs.github.com
- Git教程：https://git-scm.com/book/zh/v2
- SSH设置：https://docs.github.com/en/authentication/connecting-to-github-with-ssh

---

需要帮助？检查上面的故障排除部分，或在GitHub上创建Issue。

祝推送顺利！🎉
