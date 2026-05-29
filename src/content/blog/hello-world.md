---
title: 用 Astro 写技术笔记的第一步
description: 记录这个博客的内容结构，以及 Markdown frontmatter 如何承载文章元数据。
date: 2026-05-25
image: "@assets/blog/emmy-noether.jpg"
imageAlt: 技术笔记封面
categories: [技术笔记]
tags: [Astro, Markdown]
---

Astro 的内容集合很适合写个人博客，因为文章本身可以继续保持 Markdown 的轻量形态，同时又能通过 frontmatter 给每篇文章加上结构化信息。

比如这篇文章顶部的 `title`、`description`、`date`、`categories` 和 `tags`，会被页面、搜索、分类页和分享卡片复用。

## 我准备保留的文章字段

- `title`：文章标题。
- `description`：列表页和搜索结果里显示的摘要。
- `date`：发布时间。
- `categories`：文章所属主线，比如技术笔记、个人随笔、项目日志。
- `tags`：更细的主题，比如 Astro、Markdown、AI、前端等。

先把信息结构定下来，后面写文章会轻很多。
