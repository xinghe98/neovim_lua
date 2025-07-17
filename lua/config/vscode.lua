-- VSCode Neovim 配置
-- 加载VSCode专用插件
require("config.vscode-plugins")

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local opt = { noremap = true }

-- 基础设置
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 基础快捷键映射
keymap("", ";", ":", opt)
keymap("", "Y", '"+y', opt)

-- 自定义移动键位 (Colemak风格)
keymap("", "n", "h", opt)  -- 左
keymap("", "e", "j", opt)  -- 下
keymap("", "u", "k", opt)  -- 上
keymap("", "i", "l", opt)  -- 右
keymap("", "h", "e", opt)  -- 到词尾
keymap("", "m", "n", opt)  -- 下一个搜索
keymap("", "M", "N", opt)  -- 上一个搜索

-- 标记
keymap("n", "'", "m", opt)

-- 快速移动
keymap("", "U", "5k", opts)
keymap("", "E", "5j", opts)
keymap("", "N", "0", opts)   -- 行首
keymap("", "I", "$", opts)   -- 行尾
keymap("", "<C-U>", "5<C-y>", opts)
keymap("", "<C-E>", "5<C-e>", opts)
keymap("", "yh", "ye", opts)

-- 编辑操作
keymap("", "l", "u", opts)      -- 撤销
keymap("", "k", "i", opts)      -- 插入
keymap("", "K", "I", opts)      -- 行首插入
keymap("", "C", "~", opts)      -- 切换大小写
keymap("", "W", "b", opts)      -- 上一个词
keymap("v", "k", "xi", opts)    -- 选择模式下删除并插入
keymap("n", "<C-k>", "<C-i>", opts)

-- 缩进
keymap("n", "<S-Tab>", "<<", opts)
keymap("n", "<Tab>", ">>", opts)
keymap("v", "<S-Tab>", "<", opts)
keymap("v", "<Tab>", ">", opts)

-- 取消高亮
keymap("n", "qq", ":nohlsearch<CR>", opts)

-- 保存和退出
keymap("n", "<S-s>", ":w<CR>", opts)
keymap("n", "<S-q>", ":q<CR>", opts)

-- VSCode 特定命令
local function vscode_call(command)
  return string.format("<cmd>call VSCodeNotify('%s')<CR>", command)
end

local function vscode_call_range(command)
  return string.format("<cmd>call VSCodeNotifyRange('%s', line('.'), line('.'), 1)<CR>", command)
end

-- 窗口导航 (使用VSCode的窗口切换)
keymap("n", "<leader>i", vscode_call("workbench.action.focusRightGroup"), opts)
keymap("n", "<leader>u", vscode_call("workbench.action.focusAboveGroup"), opts)
keymap("n", "<leader>n", vscode_call("workbench.action.focusLeftGroup"), opts)
keymap("n", "<leader>e", vscode_call("workbench.action.focusBelowGroup"), opts)

-- 标签页导航
keymap("n", "<leader>1", vscode_call("workbench.action.openEditorAtIndex1"), opts)
keymap("n", "<leader>2", vscode_call("workbench.action.openEditorAtIndex2"), opts)
keymap("n", "<leader>3", vscode_call("workbench.action.openEditorAtIndex3"), opts)
keymap("n", "<leader>4", vscode_call("workbench.action.openEditorAtIndex4"), opts)
keymap("n", "<leader>5", vscode_call("workbench.action.openEditorAtIndex5"), opts)
keymap("n", "<leader>6", vscode_call("workbench.action.openEditorAtIndex6"), opts)
keymap("n", "<leader><leader>", vscode_call("workbench.action.nextEditor"), opts)
keymap("n", "<leader><backspace>", vscode_call("workbench.action.previousEditor"), opts)
keymap("n", "<c-w>", vscode_call("workbench.action.closeActiveEditor"), opts)

-- 注释
keymap("n", "<C-/>", vscode_call_range("editor.action.commentLine"), opts)
keymap("v", "<C-/>", vscode_call("editor.action.commentLine"), opts)
keymap("n", "<C-_>", vscode_call_range("editor.action.commentLine"), opts)
keymap("v", "<C-_>", vscode_call("editor.action.commentLine"), opts)

-- 文件浏览器
keymap("n", "tt", vscode_call("workbench.view.explorer"), opts)

-- LSP 功能
keymap("n", "gd", vscode_call("editor.action.revealDefinition"), opts)
keymap("n", "gr", vscode_call("editor.action.goToReferences"), opts)
keymap("n", "gi", vscode_call("editor.action.goToImplementation"), opts)
keymap("n", "gh", vscode_call("editor.action.showHover"), opts)
-- 修复 M-a 为正确的代码操作命令
keymap("n", "<M-a>", vscode_call("editor.action.sourceAction"), opts)
keymap("v", "<M-a>", vscode_call("editor.action.sourceAction"), opts)
keymap("n", "<M-A>", vscode_call("editor.action.refactor"), opts)
keymap("n", "<leader>rn", vscode_call("editor.action.rename"), opts)
-- 使用不同的快捷键避免冲突
keymap("n", "<leader>en", vscode_call("editor.action.marker.next"), opts)
keymap("n", "<leader>ep", vscode_call("editor.action.marker.prev"), opts)
keymap("n", "<leader>ge", vscode_call("editor.action.showHover"), opts)
keymap("n", "<leader>gg", vscode_call("workbench.actions.view.problems"), opts)

-- 签名帮助
keymap("n", "<M-h>", vscode_call("editor.action.triggerParameterHints"), opts)
keymap("i", "<M-h>", vscode_call("editor.action.triggerParameterHints"), opts)

-- 多光标 (VSCode 原生支持)
keymap("n", "<C-e>", vscode_call("editor.action.addCursorBelow"), opts)
keymap("n", "<C-u>", vscode_call("editor.action.addCursorAbove"), opts)
keymap("n", "<leader>a", vscode_call("editor.action.selectHighlights"), opts)
keymap("n", "<leader>d", vscode_call("editor.action.addSelectionToNextFindMatch"), opts)

-- Flash/跳转 - 移除这些行，因为现在由Flash插件处理
-- keymap("n", "s", vscode_call("workbench.action.gotoSymbol"), opts)
-- keymap("n", "<A-s>", vscode_call("workbench.action.showAllSymbols"), opts)

-- 搜索
keymap("n", "<leader>ff", vscode_call("workbench.action.quickOpen"), opts)
keymap("n", "<leader>fg", vscode_call("workbench.action.findInFiles"), opts)
keymap("n", "<leader>fb", vscode_call("workbench.action.showAllEditors"), opts)
-- 添加 C-g 快捷键用于全局搜索
keymap("n", "<C-g>", vscode_call("workbench.action.findInFiles"), opts)

-- 终端
keymap("n", "<C-t>", vscode_call("workbench.action.terminal.toggleTerminal"), opts)

-- 翻译 (如果有相关扩展)
keymap("n", "<leader>t", vscode_call("extension.translateText"), opts)
keymap("v", "<leader>t", vscode_call("extension.translateText"), opts)

-- 运行代码 (使用VSCode的运行功能)
keymap("n", "r", vscode_call("workbench.action.debug.start"), opts)

-- TODO 注释跳转 (如果有相关扩展)
vim.keymap.set("n", "]t", function()
  vim.fn.VSCodeNotify("todohighlight.listAnnotations")
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  vim.fn.VSCodeNotify("todohighlight.listAnnotations")
end, { desc = "Previous todo comment" })

-- 选择模式下字母直接插入
for char = string.byte("a"), string.byte("z") do
  local lowercase_char = string.char(char)
  local uppercase_char = string.char(char - 32)

  vim.keymap.set("s", lowercase_char, function()
    return lowercase_char
  end, { noremap = true, silent = true, expr = true })

  vim.keymap.set("s", uppercase_char, function()
    return uppercase_char
  end, { noremap = true, silent = true, expr = true })
end

-- Markdown 快捷键 (在VSCode中使用)
local function setup_markdown_keymaps()
  if vim.bo.filetype == "markdown" then
    -- 这些快捷键在VSCode中可能需要相应的扩展支持
    keymap("i", ",f", "<Esc>/<++><CR>:nohlsearch<CR>\"_c4l", opts)
    keymap("i", ",w", "<Esc>/ <++><CR>:nohlsearch<CR>\"_c5l<CR>", opts)
    keymap("i", ",b", "**** <++><Esc>F*hi", opts)
    keymap("i", ",s", "~~~~ <++><Esc>F~hi", opts)
    keymap("i", ",i", "** <++><Esc>F*i", opts)
    keymap("i", ",d", "`` <++><Esc>F`i", opts)
    keymap("i", ",c", "```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA", opts)
    keymap("i", ",m", "- [ ]", opts)
    keymap("i", ",p", "![](<++>) <++><Esc>F[a", opts)
    keymap("i", ",a", "[](<++>) <++><Esc>F[a", opts)
    keymap("i", ",1", "#<Space><Enter><++><Esc>kA", opts)
    keymap("i", ",2", "##<Space><Enter><++><Esc>kA", opts)
    keymap("i", ",3", "###<Space><Enter><++><Esc>kA", opts)
    keymap("i", ",4", "####<Space><Enter><++><Esc>kA", opts)
    keymap("i", ",l", "--------<Enter>", opts)
  end
end

-- 自动命令设置
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = setup_markdown_keymaps,
})

-- 补全相关 (VSCode 有内置补全)
keymap("i", "<Tab>", "<C-n>", opts)
keymap("i", "<S-Tab>", "<C-p>", opts)
keymap("i", "<CR>", "<CR>", opts)
keymap("i", "<ESC>", "<ESC>", opts)