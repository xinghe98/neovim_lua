
<!-- TOC Marked -->

+ [展示](#展示)
+ [安装方法](#安装方法)
+ [键盘配置映射表](#键盘配置映射表)

<!-- /TOC -->
# 展示
![](./assets/1.gif)

# 安装方法

此分支使用的是nvim+lsp配置，但与之前的main分支(coc)安装方式完全相同，**但是** main分支的安装会有些许变化，
因转为lsp，因此main分支不再做更新。

安装方法及其他依赖详见：[REDME](https://github.com/xinghe98/neovim_lua/tree/main#usage) 

# 键盘配置映射表

| 模式   |         快捷键        |       操作      |          说明          |
|--------|:---------------------:|:---------------:|:----------------------:|
| normal |           H           |        ^        |     快速移动至行首     |
| normal |           L           |        $        |     快速移动至行尾     |
| normal |       \<leader>l      |      <C-w>l     |   将焦点移动至左窗口   |
| normal |       \<leader>k      |      <C-w>k     |   将焦点移动至上窗口   |
| normal |       \<leader>h      |      <C-w>h     |   将焦点移动下至窗口   |
| normal |       \<leader>j      |      <C-w>j     |   将焦点移动至右窗口   |
| normal |         S-tab         |        <<       |        减少缩进        |
| normal |          tab          |        >>       |          缩进          |
| visual |         S-tab         |        <        |        减少缩进        |
| visual |          tab          |        >        |          缩进          |
|        |           J           |        5j       |         下移5行        |
|        |           K           |        5k       |         上移5行        |
| normal |           qq          |   :nohlsearch   |      退出搜索高亮      |
| normal |   \<leader>\<leader>  |       :bn       | 移动到下一个buffer窗口 |
| normal | \<leader>\<backspace> |       :bp       | 移动到上一个buffer窗口 |
| normal      |         \<c-w>        |       :bd       |          关闭当前buffer窗口|
| normal      |         \<S-s>        |        :w       |          <++>          |
| normal      |         \<S-q>        |        :q       |          <++>          |
| insert      |         \<C-a>        |     \<Home>     |          <++>          |
| insert      |         \<C-e>        |      \<End>     |          <++>          |
| normal |       \<leader>t      | :TranslateW<CR> |          <++>          |
| visual |       \<leader>t      | :TranslateW<CR> |          <++>          |
| normal      |           (           |        %        |                        |
