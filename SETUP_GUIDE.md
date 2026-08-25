# 🔧 完整环境配置指南

这个Obsidian仪表板需要特定的插件和配置。本指南将逐步引导你完成设置。

---

## 📋 系统要求

- ✅ Obsidian 1.0+
- ✅ 现代浏览器（支持Canvas）
- ✅ 互联网连接（用于加载CDN资源）

---

## 🎯 必需插件

### 1️⃣ **Dataview**（必需）

这是仪表板的核心。DataviewJS允许运行动态查询和可视化。

**安装步骤：**
1. 打开Obsidian → 设置 ⚙️
2. 左侧菜单 → Community plugins
3. 搜索 `Dataview`
4. 点击 "Install"
5. 点击 "Enable"

**配置：**
- 设置 → Dataview
- 确保 "JavaScript Queries" 已启用 ✅
- 确保 "Inline Queries" 已启用 ✅

**验证安装：**
在任何note中创建一个测试块：
````markdown
```dataviewjs
dv.el("div", "✅ Dataview正常工作！")
```
````

---

## 📦 可选但推荐的插件

### 2️⃣ **Periodic Notes**（可选但推荐）
用于自动创建日记、周记、月记。

**安装：**
1. Community plugins → 搜索 `Periodic Notes`
2. Install → Enable

**配置：**
- 设置 → Periodic Notes
- 自定义日期格式和文件夹位置

### 3️⃣ **Tasks**（可选）
更强大的任务管理功能（可选）。

---

## 📁 文件夹结构配置

创建以下文件夹结构（推荐）：

```
你的Obsidian仓库/
├── Dashboard/
│   ├── Homepage.md          ← 主仪表板
│   ├── Project List.md      ← 项目数据
│   └── Todo List.md         ← 待办任务
├── Projects/
│   ├── 项目1.md
│   ├── 项目2.md
│   └── README.md
├── Notes/
│   ├── 日常笔记
│   └── ...
└── Archive/
    └── 归档文件
```

---

## ⚙️ 核心配置步骤

### 步骤1️⃣：创建Dashboard文件夹

1. 在Obsidian中新建文件夹：`Dashboard`
2. 在Dashboard中创建三个文件：
   - `Homepage.md` - 复制本仓库的Homepage.md内容
   - `Project List.md` - 项目管理
   - `Todo List.md` - 待办任务

### 步骤2️⃣：配置Project List.md

这个文件存储你的项目数据。复制以下内容：

```yaml
---
tags: project-list
projects:
  - name: 我的第一个项目
    status: active
    priority: high
    progress: 50
  - name: 学习Obsidian
    status: active
    priority: medium
    progress: 30
---

# 项目列表

在上面的YAML中添加你的项目。
```

**项目字段说明：**
- `name` - 项目名称
- `status` - 状态：`active`|`paused`|`done`|`backlog`
- `priority` - 优先级：`high`|`medium`|`low`
- `progress` - 进度：0-100的数字

### 步骤3️⃣：配置Todo List.md

复制以下内容：

```markdown
# 待办清单

## 今日任务
- [ ] 任务1
- [ ] 任务2

## 本周任务
- [ ] 任务3 #priority/high
- [x] 任务4 ✅ 2026-08-26

## 本月任务
- [ ] 任务5 📌
```

**任务格式说明：**
- `[ ]` - 未完成
- `[x]` - 已完成
- `📌` - 固定在前面
- `#priority/high` - 高优先级标签
- `✅ YYYY-MM-DD` - 完成日期

---

## 🎨 Obsidian主题配置

### 推荐主题
- **浅色**：默认Light主题
- **深色**：默认Dark主题或Minimal主题

### 字体配置（可选）
仪表板使用Figtree字体，从Google Fonts CDN加载。

如果想本地使用，可以在设置中修改：
```css
font-family: 'Figtree', BlinkMacSystemFont, sans-serif;
```

---

## 🌐 CDN资源

仪表板会从以下CDN加载资源：

1. **Chart.js** - 数据可视化
   ```
   https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js
   ```

2. **Google Fonts** - Figtree字体
   ```
   https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600&display=swap
   ```

3. **Moment.js** - 日期处理（Obsidian内置）

⚠️ **注意：** 如果无法访问CDN，图表将无法显示。

---

## 📝 数据存储

### localStorage 存储
仪表板使用浏览器 `localStorage` 保存：
- 🔤 语言偏好设置（中/英）
- ⏱️ 番茄时钟数据（每日专注时间）

**位置：** `browser localStorage`

**清除数据：**
在浏览器开发工具中运行：
```javascript
localStorage.clear()
```

### 文件系统存储
项目和任务数据存储在Markdown文件中：
- `Dashboard/Project List.md`
- `Dashboard/Todo List.md`

---

## ✅ 完整检查清单

配置完成后，检查以下项目：

- [ ] ✅ Obsidian已安装
- [ ] ✅ Dataview插件已安装并启用
- [ ] ✅ 创建了`Dashboard`文件夹
- [ ] ✅ 复制了`Homepage.md`文件
- [ ] ✅ 创建了`Project List.md`并添加示例项目
- [ ] ✅ 创建了`Todo List.md`并添加示例任务
- [ ] ✅ 在主页创建了指向`Homepage.md`的链接
- [ ] ✅ 能访问互联网（CDN资源）
- [ ] ✅ 打开Homepage.md，仪表板正常显示

---

## 🆘 常见问题

### ❓ 图表不显示

**原因：** Chart.js CDN无法加载

**解决方案：**
1. 检查网络连接
2. 检查CDN URL是否可访问
3. 尝试刷新页面（Ctrl+R）

### ❓ 数据没有更新

**原因：** 文件格式不正确

**解决方案：**
1. 检查`Project List.md`的YAML格式
2. 确保文件名完全匹配
3. 检查缩进是否正确（YAML对缩进敏感）

### ❓ 番茄时钟数据丢失

**原因：** localStorage被清除或浏览器数据被删除

**解决方案：**
1. 不要清除浏览数据
2. 定期备份Obsidian仓库

### ❓ 任务没有识别

**原因：** 任务格式不正确

**解决方案：**
正确格式：
```markdown
- [x] 任务名称 ✅ YYYY-MM-DD
```
需要完全匹配这个格式。

---

## 🔄 后续维护

### 定期备份
```bash
# 备份仓库
git add .
git commit -m "定期备份"
git push
```

### 更新插件
- Obsidian会自动检查插件更新
- 建议启用自动更新

### 清理数据
定期清理已完成的任务和过期的项目。

---

## 📚 更多帮助

- **Obsidian官方文档**: https://help.obsidian.md
- **Dataview文档**: https://blacksmithgu.github.io/obsidian-dataview/
- **本项目GitHub**: https://github.com/yuze-ji/obsidian-dashboard-template

---

## 🎉 配置完成！

现在你可以：
1. 📊 查看笔记活动热力图
2. ⏱️ 使用番茄时钟
3. 🎯 管理项目和任务
4. 📈 查看数据统计

祝你使用愉快！🚀
