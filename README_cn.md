<div align="center">
  <img src="src/assets/astrogon-logo.svg" style="width:80%;" alt="Astrogon Logo" align="center" />
</div>

---

[![GitHub License](https://img.shields.io/github/license/astrogon/astrogon?color=red)](https://github.com/astrogon/astrogon/blob/main/LICENSE) [![Repo Size](https://img.shields.io/github/repo-size/astrogon/astrogon)](https://github.com/astrogon/astrogon) ![GitHub branch check runs](https://img.shields.io/github/check-runs/astrogon/astrogon/main) [![Website](https://img.shields.io/website?up_message=online&up_color=limegreen&down_message=offline&down_color=yellow&url=https%3A%2F%2Fastrogon.reednel.com%2F)](https://astrogon.reednel.com/)

Astrogon 是一个可快速自定义的多用途网站模板，使用 Astro JS、Tailwind，并加入少量 React 构建。

## 功能

### 内容集合

- 博客
  - 实现了**分类**和**标签**，便于筛选和搜索
- 文档
  - **多级**文档结构
  - 可切换的**文档浏览器**侧边栏
  - 可切换的**目录**侧边栏
- 食谱
  - 展示高度**模板化的结构**
- 作者 - 一个可通过作者字段**跨集合关联条目**的集合
- 诗歌 - 面向轻量集合的简洁界面，展示了内容页面的分页
- 索引卡片 - “诗歌”布局的一种变体，所有内容保存在单个文件中，并显示在单个页面里
- 更多内容：
  - 主页
  - 关于/简介
  - 作品集
  - 条款与条件
  - 404 页面

#### 内容组件与功能

- **手风琴**/可折叠区块
- **标签页**区块
- 带语法高亮的**代码块**
- **引用块**
- **提示块** - 备注、技巧、信息和警告
- **嵌入式 YouTube 视频**
- 集成 **LaTeX** 支持，可用于行内和块级数学表达式
- 支持所有标准 **MD/MDX** 功能，包括脚注、表格等

### 其他功能

- 全面支持**浅色模式**和**深色模式**，并可自动检测系统偏好
- 可对你选择包含的所有内容进行**搜索**
- 面向所有屏幕尺寸的**自适应布局**，从手机到桌面显示器都适用
- 可无缝添加到任何可交互元素上的**工具提示**
- 用于快速导航的**面包屑**
- 可为任意内容集合自动填充的**相关内容**区块
- 可为任意内容集合自动计算的**阅读时间**
- 所有组件均可切换的**磨砂玻璃**效果
- 易于自定义的配色方案和排版
- 优雅点缀用的组件**过渡动画**
- 任意内容集合均支持**分页**
- 用于**社交媒体**分享的组件
- 内置的**搜索引擎优化**模式

这些功能在设计时都充分考虑了模块化与可自定义性，以尽可能提供流畅的开发体验。更多详情请参见 [docs/customization.md](docs/customization.md)。

## 推荐技术

- [Git](https://git-scm.com)
- [Node Version Manager](https://github.com/nvm-sh/nvm)
- [Visual Studio Code](https://code.visualstudio.com/)

更多详情请参见 [docs/tech-stack.md](docs/tech-stack.md)。

## 开发说明

1. 将此仓库 Fork 到你自己的 GitHub 账号，然后克隆到本地机器
2. 使用 Node 22：`nvm install 22` 或 `nvm use 22`
3. 在项目目录中安装 Node 依赖：`npm install`
4. 在项目目录中构建/启动开发环境：`npm run dev`
   1. 也可以使用*：`npx astro build`、`npx wrangler dev`
5. 在 `http://localhost:4321` 实时查看你的修改

> *如果你打算将网站部署到 Cloudflare，这一点很相关。从 Astro 5.8 开始，Node 18 已不受支持，但旧版 Cloudflare Pages 默认使用 Node 18。若要使用新的 Cloudflare Workers，似乎需要 Wrangler。可在[这里](https://docs.astro.build/en/guides/deploy/cloudflare/#cloudflare-workers)阅读 Astro 部署相关说明。

## 许可证

Astrogon 使用 [MIT License](LICENSE) 授权。

## 致谢

此模板最初受到 [zeon-studio](https://github.com/zeon-studio) 的 [astroplate](https://github.com/zeon-studio/astroplate)、[jordienr](https://github.com/jordienr) 的 [astro-design-system](https://github.com/jordienr/astro-design-system)，以及 [TheOtterlord](https://github.com/TheOtterlord) 的 [manual](https://github.com/TheOtterlord/manual) 项目结构启发。

## 赞助

[reednel](https://github.com/reednel) 已投入数百小时构建此模板，并持续维护和改进它。该软件完全免费且开源，但如果你觉得它有价值，欢迎在[[这里](https://github.com/sponsors/reednel)]进行小额捐赠，作者会非常感谢。
