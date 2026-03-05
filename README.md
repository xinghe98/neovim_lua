# ⌨️ Neovim Configuration (Colemak-DH)

> 基于 [LazyVim](https://github.com/LazyVim/LazyVim) 的个人 Neovim 配置，深度适配 **Colemak-DH** 键盘布局，集成 AI 编程助手、Flutter 开发工具链，支持 Windows / WSL / Linux 跨平台使用。

<img width="2658" height="1412" alt="swappy-20260305-221926" src="https://github.com/user-attachments/assets/8d4394f7-ecda-411b-a1fc-313e54c6dac3" />


## ✨ 特性概览

- 🧠 **Colemak-DH 全局适配** — 移动键 `n/e/u/i` 替代 `h/j/k/l`，所有插件按键均已重映射
- 🤖 **AI 编程助手** — CodeCompanion (OpenRouter / DeepSeek / Yunwu) + Copilot 双引擎
- 🎨 **精调 UI** — Everforest 主题 + 透明背景 + 自定义补全高亮 + Bubbles 状态栏
- 🛠️ **多语言 LSP** — Go / Python / TypeScript / Vue / Dart(Flutter) / Kotlin / Lua / JSON / Prisma
- 📝 **Markdown 增强** — 快捷输入、实时预览、自动目录、表格对齐、fcitx5 输入法联动
- 🖥️ **Neovide GUI 支持** — 半透明毛玻璃 + Consolas Nerd Font

## 📁 目录结构

```
nvim/
├── init.lua                    # 入口文件
├── lazyvim.json                # LazyVim extras 配置
├── lazy-lock.json              # 插件版本锁定
├── stylua.toml                 # Lua 代码格式化配置
├── user_config.ahk             # Windows AHK Colemak 键位映射
├── snippets/
│   └── dart.lua                # Dart/Flutter 自定义代码片段
└── lua/
    ├── config/
    │   ├── lazy.lua            # lazy.nvim 引导与插件加载
    │   ├── options.lua         # 编辑器全局选项
    │   ├── keymaps.lua         # 全局键位映射 (Colemak-DH)
    │   ├── autocmds.lua        # 自动命令 (nvim-tree 窗口管理等)
    │   ├── customhighlight.lua # 自定义高亮组
    │   ├── markdown.lua        # Markdown 快捷键 + fcitx5 集成
    │   └── neovide.lua         # Neovide GUI 配置
    └── plugins/
        ├── colorscheme.lua     # 主题 (Everforest / Gruvbox / OneDark)
        ├── lspconfig.lua       # LSP 服务器配置与 Lspsaga 键位
        ├── blinkcmp.lua        # blink.cmp 补全引擎 (含自定义高亮)
        ├── lualine.lua         # 状态栏 (Bubbles 主题 + LSP 状态)
        ├── nvim-tree.lua       # 文件树 (Colemak 适配)
        ├── bufferline.lua      # 标签页栏
        ├── telescope.lua       # 模糊搜索 (Telescope)
        ├── snacks.lua          # Snacks (Picker / Indent / Notifier)
        ├── noice.lua           # 通知与命令行 UI
        ├── flash.lua           # 快速跳转
        ├── flutterTool.lua     # Flutter 开发工具链
        ├── copilot.lua         # GitHub Copilot
        ├── codecompanion/      # CodeCompanion AI (模块化配置)
        │   ├── init.lua        #   主配置
        │   ├── adapters.lua    #   AI 模型适配器
        │   ├── strategies.lua  #   策略配置
        │   ├── keymaps.lua     #   快捷键
        │   ├── prompts.lua     #   自定义提示词
        │   └── extensions.lua  #   扩展
        ├── lspsaga.lua         # LSP UI 增强
        ├── multiple_cursors.lua# 多光标编辑
        ├── rip-substring.lua   # 正则替换
        ├── lazygit.lua         # Git 可视化
        ├── gitsigns.lua        # Git 变更标记
        ├── translate.lua       # 翻译 (中文)
        ├── marks.lua           # 书签管理
        ├── action_hints.lua    # 操作提示
        ├── highlight_colors.lua# 颜色高亮
        ├── render_markdown.lua # Markdown 渲染
        ├── markdown.lua        # Markdown 工具 (TOC / 表格)
        ├── nvim-treesitter.lua # 语法高亮
        ├── which_key.lua       # 快捷键提示
        ├── disabled.lua        # 禁用的插件
        ├── windsurf.lua        # Windsurf/Codeium (已注释)
        └── tsTool.lua          # TypeScript Tools (已注释)
```

## ⌨️ Colemak-DH 键位映射

本配置的核心是对 **Colemak-DH** 布局的全面适配。以下是基础移动键的重映射：

### 基础移动

| 按键 | 原 Vim 功能 | 本配置功能   |
| ---- | ----------- | ------------ |
| `n`  | 下一个搜索  | ← 左移 (`h`) |
| `e`  | 词尾        | ↓ 下移 (`j`) |
| `u`  | 撤销        | ↑ 上移 (`k`) |
| `i`  | 插入        | → 右移 (`l`) |
| `N`  | —           | 行首 (`0`)   |
| `I`  | —           | 行尾 (`$`)   |
| `U`  | —           | 上移 5 行    |
| `E`  | —           | 下移 5 行    |

### 功能键重映射

| 按键      | 功能                        |
| --------- | --------------------------- |
| `k`       | 进入插入模式 (`i`)          |
| `K`       | 行首插入 (`I`)              |
| `l`       | 撤销 (`u`)                  |
| `h`       | 词尾移动 (`e`)              |
| `m` / `M` | 下/上一个搜索匹配 (`n`/`N`) |
| `'`       | 设置标记 (`m`)              |
| `C`       | 切换大小写 (`~`)            |
| `W`       | 向前跳词 (`b`)              |
| `;`       | 进入命令模式 (`:`)          |

### 窗口导航

| 按键        | 功能         |
| ----------- | ------------ |
| `<leader>n` | 跳转到左窗口 |
| `<leader>e` | 跳转到下窗口 |
| `<leader>u` | 跳转到上窗口 |
| `<leader>i` | 跳转到右窗口 |

### 标签页操作

| 按键                  | 功能            |
| --------------------- | --------------- |
| `<leader>1~6`         | 跳转到标签 1~6  |
| `<leader><leader>`    | 下一个 buffer   |
| `<leader><backspace>` | 上一个 buffer   |
| `<C-w>`               | 关闭当前 buffer |

## 🔌 插件列表

### 🤖 AI 编程

| 插件                                                                  | 说明                                      |
| --------------------------------------------------------------------- | ----------------------------------------- |
| [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim) | AI 编程助手，支持 Chat / Inline / Actions |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua)              | GitHub Copilot 代码补全                   |
| [action-hints.nvim](https://github.com/roobert/action-hints.nvim)     | LSP 操作虚拟文本提示                      |

**CodeCompanion 快捷键：**

| 按键         | 功能                                                        |
| ------------ | ----------------------------------------------------------- |
| `<leader>aa` | 切换 AI 对话窗口 (Normal) / 对选中文本输入 AI 指令 (Visual) |
| `<leader>ao` | 将选中文本发送到 AI 对话 (Visual)                           |
| `<leader>ac` | 打开 AI 操作面板                                            |
| `<leader>am` | 生成中文 Git Commit Message                                 |

**CodeCompanion 适配器：**

- **Chat 模式**: Yunwu 代理 (Claude Sonnet 4 / Claude Opus 4 / Gemini 3 Pro)
- **Inline 模式**: DeepSeek Chat
- **备选**: OpenRouter (MiniMax / Claude / GPT-4o / Gemini)

**Copilot 快捷键：**

| 按键              | 功能              |
| ----------------- | ----------------- |
| `<C-q>`           | 接受 Copilot 建议 |
| `<C-n>` / `<C-p>` | 下/上一条建议     |

### 🎨 UI 与主题

| 插件                                                                           | 说明                                            |
| ------------------------------------------------------------------------------ | ----------------------------------------------- |
| [everforest-nvim](https://github.com/neanias/everforest-nvim)                  | **当前主题**，透明背景                          |
| [gruvbox-material](https://github.com/sainnhe/gruvbox-material)                | Gruvbox 主题 (备选)                             |
| [onedarkpro.nvim](https://github.com/olimorris/onedarkpro.nvim)                | OneDark 主题 (备选)                             |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                   | 状态栏 (Bubbles 主题，显示 LSP / Snippets 状态) |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                  | 标签页栏 (序号 + LSP 诊断)                      |
| [noice.nvim](https://github.com/folke/noice.nvim)                              | 通知 / 命令行 / 搜索 UI 美化                    |
| [snacks.nvim](https://github.com/folke/snacks.nvim)                            | 缩进线 (chunk 样式) / Picker / 通知             |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)  | 彩虹括号                                        |
| [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors) | 颜色值高亮                                      |
| [mini.icons](https://github.com/echasnovski/mini.icons)                        | 图标                                            |

### 📂 导航与搜索

| 插件                                                               | 说明                  | 快捷键                        |
| ------------------------------------------------------------------ | --------------------- | ----------------------------- |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)        | 文件树 (Colemak 适配) | `tt`                          |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | 模糊搜索              | `<leader>ff` / `<leader>gg`   |
| [snacks.picker](https://github.com/folke/snacks.nvim)              | 高级搜索              | `<C-f>` 文件 / `<C-g>` 搜索   |
| [flash.nvim](https://github.com/folke/flash.nvim)                  | 快速跳转              | `s` 跳转 / `<A-s>` Treesitter |
| [marks.nvim](https://github.com/chentoast/marks.nvim)              | 书签管理              | `'` 设置 / `m` 下一个         |

### ✏️ 编辑增强

| 插件                                                                               | 说明                      | 快捷键                                    |
| ---------------------------------------------------------------------------------- | ------------------------- | ----------------------------------------- |
| [blink.cmp](https://github.com/saghen/blink.cmp)                                   | 补全引擎 (LuaSnip 后端)   | `<CR>` 确认 / `<Tab>` 选择                |
| [multiple-cursors.nvim](https://github.com/brenton-leighton/multiple-cursors.nvim) | 多光标编辑                | `<leader>a` 全匹配 / `<leader>d` 逐个匹配 |
| [nvim-rip-substitute](https://github.com/chrisgrieser/nvim-rip-substitute)         | 正则搜索替换              | `<C-h>`                                   |
| [mini.surround](https://github.com/echasnovski/mini.surround)                      | 环绕编辑                  | —                                         |
| [mini.comment](https://github.com/echasnovski/mini.comment)                        | 注释                      | `<C-/>`                                   |
| [mini.pairs](https://github.com/echasnovski/mini.pairs)                            | 自动括号                  | —                                         |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)                       | 自动闭合/重命名 HTML 标签 | —                                         |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                     | 代码片段引擎              | —                                         |
| [tabular](https://github.com/godlygeek/tabular)                                    | 文本对齐                  | —                                         |

### 🧪 LSP & 开发工具

| 插件                                                                         | 说明                                |
| ---------------------------------------------------------------------------- | ----------------------------------- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                   | LSP 客户端配置                      |
| [lspsaga.nvim](https://github.com/nvimdev/lspsaga.nvim)                      | LSP UI (悬浮文档/代码操作/诊断跳转) |
| [mason.nvim](https://github.com/williamboman/mason.nvim)                     | LSP/DAP/Linter 包管理器             |
| [conform.nvim](https://github.com/stevearc/conform.nvim)                     | 格式化 (Prettier)                   |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint)                       | Linter                              |
| [flutter-tools.nvim](https://github.com/akinsho/flutter-tools.nvim)          | Flutter/Dart 开发全流程             |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)        | 语法高亮与文本对象                  |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim)                        | Neovim Lua 开发辅助                 |
| [venv-selector.nvim](https://github.com/linux-cultivator/venv-selector.nvim) | Python 虚拟环境选择                 |

**LSP 快捷键：**

| 按键              | 功能             |
| ----------------- | ---------------- |
| `gd`              | 跳转到定义       |
| `gr`              | 跳转到引用       |
| `gi`              | 跳转到实现       |
| `gh`              | 查看悬浮文档     |
| `<M-a>`           | 代码操作         |
| `<leader>rn`      | 重命名变量       |
| `<C-e>` / `<C-u>` | 下/上一个诊断    |
| `<leader>ge`      | 查看详细错误信息 |
| `<leader>gg`      | 查看所有诊断     |
| `<M-h>`           | 签名帮助         |

### 🔗 Git

| 插件                                                        | 说明              | 快捷键       |
| ----------------------------------------------------------- | ----------------- | ------------ |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)    | LazyGit 可视化    | `<leader>lg` |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | 行内 Git 变更标记 | —            |

### 📝 Markdown

| 插件                                                                                 | 说明                   |
| ------------------------------------------------------------------------------------ | ---------------------- |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)             | 浏览器实时预览         |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | 编辑器内 Markdown 渲染 |
| [vim-markdown-toc](https://github.com/mzlogin/vim-markdown-toc)                      | 自动生成目录           |
| [vim-table-mode](https://github.com/dhruvasagar/vim-table-mode)                      | 表格模式               |
| [vim-translator](https://github.com/voldikss/vim-translator)                         | 翻译 (目标: 中文)      |

**Markdown 插入模式快捷键** (`,` 前缀)：

| 按键   | 功能                      |
| ------ | ------------------------- |
| `,b`   | 粗体 `**text**`           |
| `,i`   | 斜体 `*text*`             |
| `,s`   | 删除线 `~~text~~`         |
| `,d`   | 行内代码 `` `text` ``     |
| `,c`   | 代码块                    |
| `,p`   | 图片 `![](url)`           |
| `,a`   | 链接 `[](url)`            |
| `,1~4` | 一至四级标题              |
| `,m`   | 复选框 `- [ ]`            |
| `,l`   | 横线分隔符                |
| `,f`   | 跳转到下一个占位符 `<++>` |

### 🧰 其他

| 插件                                                              | 说明                         |
| ----------------------------------------------------------------- | ---------------------------- |
| [which-key.nvim](https://github.com/folke/which-key.nvim)         | 快捷键提示面板               |
| [persistence.nvim](https://github.com/folke/persistence.nvim)     | 会话管理                     |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | TODO 高亮 (`]t` / `[t` 跳转) |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim)        | 输入/选择 UI 增强            |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim)               | LSP 进度提示                 |

## 🧩 LazyVim Extras

通过 `lazyvim.json` 启用的 LazyVim 官方扩展：

- `coding.mini-comment` — 注释
- `coding.mini-surround` — 环绕编辑
- `editor.telescope` — Telescope 搜索
- `formatting.prettier` — Prettier 格式化
- `lang.go` — Go 语言支持
- `lang.json` — JSON 支持
- `lang.kotlin` — Kotlin 支持
- `lang.prisma` — Prisma ORM 支持
- `lang.python` — Python 支持
- `lang.tailwind` — Tailwind CSS 支持
- `lang.typescript` — TypeScript 支持
- `lang.vue` — Vue.js 支持

## 🚀 一键运行

按 `r` 键（Normal 模式）根据文件类型自动运行：

| 文件类型   | 执行方式                    |
| ---------- | --------------------------- |
| Python     | `python3 %`                 |
| HTML       | 浏览器打开                  |
| Markdown   | MarkdownPreview + TableMode |
| JavaScript | `node --trace-warnings .`   |
| TypeScript | `ts-node %`                 |
| Go         | `go run .`                  |

## 🖥️ Neovide 配置

当使用 [Neovide](https://neovide.dev/) GUI 时自动启用：

- **字体**: Consolas Nerd Font, 18pt
- **透明度**: 0.8
- **毛玻璃模糊**: X=2.0, Y=2.0

## 📦 安装

### 前置依赖

- **Neovim** ≥ 0.10.0
- **Git**
- **Node.js** (用于部分 LSP 和 Prettier)
- **ripgrep** (用于 Telescope / Snacks 全局搜索)
- [Nerd Font](https://www.nerdfonts.com/) (推荐 Consolas Nerd Font，已附带 `ttf` 文件)
- [lazygit](https://github.com/jesseduffield/lazygit) (可选，Git 可视化)

### 步骤

```bash
# 备份已有配置
mv ~/.config/nvim ~/.config/nvim.bak

# 克隆配置
git clone https://github.com/<your-username>/neovim_lua.git ~/.config/nvim

# 首次启动会自动安装所有插件
nvim
```

> **Windows 用户**: 配置目录位于 `%LOCALAPPDATA%\nvim`

## ⚙️ Windows AHK 键位

附带 `user_config.ahk` 文件，用于在 Windows 全局实现 Colemak-DH 布局：

- QWERTY → Colemak 全键位映射
- `CapsLock` → `ESC`
- `Alt + 1~8` — 切换虚拟桌面
- `Alt + Shift + 1~9` — 移动窗口到虚拟桌面
- `Alt + i/k/j/l` — 方向键模拟

## 📜 License

[Apache-2.0](./LICENSE)
