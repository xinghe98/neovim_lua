<!-- TOC Marked -->

- [展示](#展示)
- [安装方法](#安装方法)
- [键盘配置映射表](#键盘配置映射表)

<!-- /TOC -->

# 展示

![](./assets/1.gif)

# 安装方法

此分支使用的是 nvim+coc 配置，lazy.nvim 进行包管理，其他的分支分别是[lsp+packer](https://github.com/xinghe98/neovim_lua/tree/use_lsp) 和[coc+packer](https://github.com/xinghe98/neovim_lua/tree/main).

```bash
# Clone the repository.
git clone https://github.com/xinghe98/neovim_lua.git ~/.config/nvim
```

```bash
cd ~/.local/share/nvim/lazy/markdown-preview.nvim

yarn install
```

```bash
sudo pacman -S python-pip go nodejs npm yarn xclip qutebrower
```

```bash
sudo pacman -S ctags
```

# 键盘配置映射表

| 模式   |        快捷键         |      操作       |           说明           |
| ------ | :-------------------: | :-------------: | :----------------------: |
| normal |           H           |        ^        |      快速移动至行首      |
| normal |           L           |        $        |      快速移动至行尾      |
| normal |      \<leader>l       |     <C-w>l      |    将焦点移动至左窗口    |
| normal |      \<leader>k       |     <C-w>k      |    将焦点移动至上窗口    |
| normal |      \<leader>h       |     <C-w>h      |    将焦点移动下至窗口    |
| normal |      \<leader>j       |     <C-w>j      |    将焦点移动至右窗口    |
| normal |         S-tab         |       <<        |         减少缩进         |
| normal |          tab          |       >>        |           缩进           |
| visual |         S-tab         |        <        |         减少缩进         |
| visual |          tab          |        >        |           缩进           |
|        |           J           |       5j        |        下移 5 行         |
|        |           K           |       5k        |        上移 5 行         |
| normal |          qq           |   :nohlsearch   |       退出搜索高亮       |
| normal |  \<leader>\<leader>   |       :bn       | 移动到下一个 buffer 窗口 |
| normal | \<leader>\<backspace> |       :bp       | 移动到上一个 buffer 窗口 |
| normal |        \<c-w>         |       :bd       |   关闭当前 buffer 窗口   |
| normal |        \<S-s>         |       :w        |           保存           |
| normal |        \<S-q>         |       :q        |           退出           |
| normal |      \<leader>t       | :TranslateW<CR> |          翻译词          |
| visual |      \<leader>t       | :TranslateW<CR> |          翻译句          |
| normal |          tt           |                 |        打开目录树        |
