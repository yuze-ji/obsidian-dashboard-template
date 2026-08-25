# 快速开始指南

## ⚡ 5分钟快速设置

### 步骤1️⃣：复制文件
1. 下载此项目
2. 将 `Homepage.md` 复制到你的Obsidian仓库 `Dashboard` 文件夹
3. 创建 `Dashboard/Project List.md` 和 `Dashboard/Todo List.md` 文件

### 步骤2️⃣：设置项目列表
打开 `Dashboard/Project List.md`，复制以下内容：

```yaml
---
tags: project-list
projects:
  - name: 我的第一个项目
    status: active
    priority: high
    progress: 50
---
```

### 步骤3️⃣：创建待办清单
打开 `Dashboard/Todo List.md`，添加你的任务：

```markdown
# 待办清单

- [ ] 学习Obsidian
- [x] 设置仪表板 ✅ 2026-08-26
- [ ] 完成项目 #priority/high
```

### 步骤4️⃣：在Obsidian中打开
1. 在你的Obsidian主页或任何地方创建链接：`[[Dashboard/Homepage.md]]`
2. 点击打开查看效果

## 🎯 核心功能使用

### 笔记活动
- 自动显示你的笔记编辑热力图
- 点击"周/月/年"切换不同视图
- 点击"中/En"切换语言

### 番茄时钟
- 输入时间（1-180分钟）点击✓设置
- 点击▶Start开始计时
- 完成后自动保存到localStorage

### 项目管理
- 在仪表板上可以直接编辑项目
- 点击项目卡片进入编辑模式
- 支持添加、删除项目

### 任务统计
- 自动识别格式：`- [x] 任务 ✅ YYYY-MM-DD`
- 高优先级任务：添加 `#priority/high` 标签
- 固定任务：在任务前加 `📌`

## 🎨 主题切换

点击右上角的"中/En"旁边，或在浏览器深色/浅色模式切换，仪表板会自动适应。

## 📊 数据来源

- **笔记数据**：自动扫描你的Obsidian仓库
- **项目数据**：来自 `Dashboard/Project List.md`
- **任务数据**：来自 `Dashboard/Todo List.md`
- **专注时间**：存储在浏览器localStorage

## ❓ 常见问题

**Q: 为什么图表不显示？**
- 检查网络连接
- 确保 Chart.js CDN 可以访问

**Q: 数据丢失了怎么办？**
- localStorage中的数据与浏览器绑定
- 建议定期备份你的Obsidian仓库

**Q: 可以修改样式吗？**
- 当然可以！编辑 `Homepage.md` 中的CSS即可

## 📚 更多信息

详细文档请查看 `README.md`

---

祝你使用愉快！🎉
