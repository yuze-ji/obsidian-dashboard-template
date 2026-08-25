---
tags: project-list
projects:
  - name: 学习Python数据分析
    status: active
    priority: high
    progress: 65
  - name: 个人博客重构
    status: active
    priority: medium
    progress: 40
  - name: Obsidian插件开发
    status: paused
    priority: high
    progress: 30
  - name: 英语学习计划
    status: active
    priority: medium
    progress: 50
  - name: 健身计划
    status: done
    priority: low
    progress: 100
---

# 项目列表示例

这是一个示例项目列表。请将此内容复制到 `Dashboard/Project List.md` 中。

## 项目格式说明

```yaml
projects:
  - name: 项目名称
    status: active          # 状态: active(进行中) | paused(暂停) | done(完成) | backlog(规划中)
    priority: high          # 优先级: high(高) | medium(中) | low(低)
    progress: 65            # 进度: 0-100
```

## 状态含义
- **active** (▶️ 进行中)：正在进行的项目
- **paused** (⏸ 暂停)：暂时停止的项目
- **done** (✓ 已完成)：已完成的项目
- **backlog** (○ 规划中)：计划中的项目

## 优先级含义
- **high** (高)：重要紧急
- **medium** (中)：正常优先级
- **low** (低)：可选项

## 提示
- 仪表板中只显示非"已完成"的项目
- 项目按优先级自动排序（高 → 中 → 低）
- 进度为百分比（0-100）
