# ⌨️ Neovim Configuration (Colemak-DH)

> 基于 [LazyVim](https://github.com/LazyVim/LazyVim) 的个人 Neovim 配置，深度适配 **Colemak-DH** 键盘布局，集成 AI 编程助手、Flutter 开发工具链，支持 Windows / WSL / Linux 跨平台使用。

<img width="2560" height="1440" alt="图片" src="https://github.com/user-attachments/assets/ae07ed6c-1a46-438a-bf4a-46483b825682" />



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

**OMP / OpenCode + Herdr：**

在同一 Herdr workspace 中启动 Neovim 和 OMP 或 OpenCode；`herdr` 命令需在 Neovim 的 `PATH` 中可用。
快捷键只将内容粘贴到 agent 输入框，不自动按 Enter 提交，也不切换焦点。

| 按键 | 模式 | 功能 |
| ---- | ---- | ---- |
| `<leader>ad` | Visual | 发送选中内容 |
| `<leader>at` | Normal / Visual | 发送当前文件的光标位置或选区范围 |
| `<leader>af` | Normal | 发送当前文件引用 |

`lua/config/omp_herdr.lua` 识别 `agent = "omp"` / `"opencode"`，自动选择仅限当前 workspace；
优先 OMP，同类优先同 tab，再匹配 Neovim 工作目录；候选并列时提示显式指定，不随意发送。
普通 Neovim 从 `herdr pane current --current` 获取实时上下文；herdr-nvim 的 headless
侧边栏 daemon 按 `HERDR_WORKSPACE_ID` / `HERDR_TAB_ID` 定位目标，不要求普通 pane 环境，
也不使用关闭重开侧边栏前留下的 pane ID。两种入口均支持 `ad/at/af`。
文件引用沿用 `@路径`（工作目录内使用相对路径），位置附加 `:L行:C列` 等范围信息；
发送文件或位置要求文件已存在磁盘，不会自动保存修改。

多个 agent 或跨 workspace 发送时，可用 `herdr pane list` 查询完整 pane ID，然后设置：

```lua
vim.g.omp_herdr_pane_id = "w1:p2" -- 替换为实际 pane_id，不是 terminal_id
```

也可在启动 Neovim 前设置环境变量 `OMP_HERDR_PANE_ID`；Lua 配置优先。
目标不能是当前 Neovim pane，关闭或移动目标后需更新 ID。

OMP 与 OpenCode 均以 `Ctrl+G` 打开现有 Neovim 配置编辑提示词：`S` 保存、`Q` 退出，
只回填草稿。Neovim 自带终端入口为 `<leader>ot`，终端模式连按两次 Esc 返回 Normal。
Herdr 的 `Ctrl+T` → `Shift+V` 阅读保留滚屏，`Ctrl+T` → `Shift+P` 按 pane 会话标识读取完整
OMP / OpenCode 会话；只读弹窗保留 Colemak、搜索和复制，`Q` 退出。滚屏受保留上限限制，
OMP 完整会话保留原生工具结果折叠；没有会话元数据时完整阅读明确报错。

Zellij 的 require 和快捷键已在 `lua/config/keymaps.lua` 中注释，旧模块 `omp_zellij.lua` 保留但不加载；
旧 `OMP_ZELLIJ_PANE_ID` / `vim.g.omp_zellij_pane_id` 不再参与目标选择，Sidekick 仍禁用。

**herdr-nvim（ChmaraX/herdr-nvim）：**

与 Herdr 双向集成的批注工作流，发送目标是 Herdr 识别的编码 agent（包括 OMP）。
批注快捷键与上面 OMP 的选区/位置快捷键共存。

- Herdr 侧（侧边栏 + 文件 picker）：`herdr plugin install ChmaraX/herdr-nvim` 安装，
  键位在 `~/.config/herdr/config.toml`：`prefix+v` 开关全高 nvim 侧边栏，
  `prefix+p` 从文件列表中模糊选择打开；优先会话记录、Git 未提交改动，缺少会话解析时扫描终端输出。
  每 tab 一个持久 headless daemon，关闭再打开侧边栏保留 buffer 和待发批注。
- Neovim 侧（批注）：`lua/plugins/herdr-nvim.lua`。
  插件启动时加载，设置 `keymaps = false`，所有批注键位由 lazy.nvim 的 `keys` 注册；
  侧边栏 daemon 在 VimEnter 再调用 setup 时，不会重复注册并弹出映射冲突警告。

`prefix+p` 不提供 diff 内容预览，行末的 `+N/-M` 只是 Git 行数统计，基准为 `HEAD`
（含已暂存和未暂存改动）；新文件显示 `new`，干净文件或非 Git 目录没有行数统计。
仓库由目标 agent 的前台工作目录决定，而不是 Neovim 当前文件所在目录。
当前版本没有 OMP 会话日志解析器，OMP 走 Git/终端输出回退，无法完整识别会话编辑历史。
要查看代码差异，在 picker 中回车打开文件后，普通模式按 `<leader>ghd` 打开并排 diff，
`<leader>ghp` 预览当前改动块；这些键位由现有 GitSigns 在文件附加后提供。
应在项目仓库中启动 agent，使 picker 的 Git 统计和仓库搜索覆盖该项目。

| 按键 | 模式 | 功能 |
| ---- | ---- | ---- |
| `<leader>ac` | Normal / Visual | 批注当前行 / 选区 |
| `<leader>al` | Normal | 批注列表（悬浮） |
| `<leader>as` | Normal | 发送全部批注到 agent（不自动提交） |
| `<leader>aS` | Normal | 发送全部批注并自动提交 |
| `<leader>ai` | Normal / Visual | 在 agent 输入框插入 `path:行号` 引用 |

Leader 是空格。若按空格不显示 which-key 菜单，可用 `:echo reg_recording()` 检查
是否正在录制宏；录宏时 which-key 会停用提示。仅在正在录制时，普通模式按 `q` 结束录制。

批注内存 ephemeral 存储（extmark 跟随编辑），发送成功后清空，附带 file:line 与 git 分支上下文；
状态栏可加 `require("herdr-nvim").statusline()` 显示待发数（`● 3`）。
要求 nvim ≥ 0.10、herdr ≥ 0.7.5，且 Neovim 运行在 herdr 会话内。
注意：`herdr-nvim doctor` 的 D-F19 检查硬编码 QWERTY `i` 进入插入模式，
在本配置的 Colemak 映射（`i`→`l`）下会误报 FAIL，可忽略；其余检查（布局、toggle 回环、daemon）均应 OK。

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

### ⚠️ Treesitter 特别说明

Treesitter 解析器需要编译，如果遇到 Treesitter 相关报错，请确保已安装以下依赖：

- **tree-sitter CLI** — 用于编译 Treesitter 解析器
- **gcc** — C 编译器，用于编译解析器

#### Windows 安装方式 (推荐使用 Scoop)

```powershell
# 安装 Scoop (如果尚未安装)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# 使用 Scoop 安装依赖
scoop install tree-sitter gcc
```

#### 其他平台

```bash
# macOS (Homebrew)
brew install tree-sitter gcc

# Linux (Debian/Ubuntu)
sudo apt install tree-sitter gcc

# Linux (Arch)
sudo pacman -S tree-sitter gcc
```

> **提示**: 如果 Treesitter 报错（如 `tree-sitter cli not found` 或编译失败），请先尝试升级这两个工具到最新版本。

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
