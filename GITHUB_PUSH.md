# 🚀 推送到GitHub步骤

## 前置条件
1. 已安装Git
2. 在GitHub上创建了空仓库
3. 已配置GitHub SSH密钥或个人访问令牌

## 推送步骤

### 1️⃣ 初始化本地仓库
```bash
cd /tmp/obsidian-dashboard-template
git init
git add .
git commit -m "初始化：Obsidian优雅仪表板模板"
```

### 2️⃣ 添加远程仓库
将 `YOUR_USERNAME` 和 `YOUR_REPO` 替换为你的实际信息：

```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
```

例如：
```bash
git remote add origin https://github.com/jiyuze/Obsidian-Dashboard-Template.git
```

### 3️⃣ 推送到GitHub
```bash
git branch -M main
git push -u origin main
```

### 4️⃣ 验证
打开GitHub，检查文件是否已上传：
- ✅ Homepage.md
- ✅ README.md
- ✅ QUICK_START.md
- ✅ Project_List_Example.md
- ✅ .gitignore

## 完整一行命令版本

如果你想一次性执行所有命令：

```bash
cd /tmp/obsidian-dashboard-template && \
git init && \
git add . && \
git commit -m "初始化：Obsidian优雅仪表板模板" && \
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git && \
git branch -M main && \
git push -u origin main
```

## 使用HTTPS或SSH

### HTTPS方式（更简单）
```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```
首次推送会要求输入GitHub用户名和个人访问令牌。

### SSH方式（更安全）
```bash
git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```
需要预先配置SSH密钥。

## 后续更新

当你修改仪表板模板后，推送更新：

```bash
git add .
git commit -m "描述你的改动"
git push
```

## 常见错误

**错误：Please tell me who you are**
```bash
git config --global user.email "your_email@example.com"
git config --global user.name "Your Name"
```

**错误：fatal: remote origin already exists**
```bash
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
```

**错误：Support for password authentication was removed**
- 使用个人访问令牌代替密码
- 或使用SSH密钥

## 📝 提示

1. 模板中的 `Homepage.md` 是演示文件，用户应该根据需要自定义
2. `.gitignore` 已配置为排除个人数据
3. 建议在README中强调这是一个模板
4. 考虑添加License文件（MIT或其他）

---

祝推送顺利！🎉
