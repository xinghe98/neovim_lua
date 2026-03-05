vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "*.mdown", "*.mkd", "*.mkdn", "*.markdown", "*.mdwn" },
  callback = function()
    vim.bo.filetype = "markdown"
    vim.opt_local.foldenable = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(ev)
    local opts = { buffer = ev.buf }
    local function map(lhs, rhs)
      vim.keymap.set("i", lhs, rhs, opts)
    end

    map(",f", '<Esc>/<++><CR>:nohlsearch<CR>"_c4l')
    map("<Esc>", "<Esc>zz")
    map(",w", '<Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>')
    map(",b", "**** <++><Esc>F*hi")
    map(",s", "~~~~ <++><Esc>F~hi")
    map(",i", "** <++><Esc>F*i")
    map(",d", "`` <++><Esc>F`i")
    map(",c", "```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA")
    map(",m", "- [ ]")
    map(",p", "![](<++>) <++><Esc>F[a")
    map(",a", "[](<++>) <++><Esc>F[a")
    map(",1", "#<Space><Enter><++><Esc>kA")
    map(",2", "##<Space><Enter><++><Esc>kA")
    map(",3", "###<Space><Enter><++><Esc>kA")
    map(",4", "####<Space><Enter><++><Esc>kA")
    map(",l", "--------<Enter>")
  end,
})
vim.g.vmt_cycle_list_item_markers = 1
vim.g.vmt_fence_text = "TOC"
vim.g.vmt_fence_closing_text = "/TOC"
vim.cmd([[
let g:input_toggle = 0
function! Fcitx2en()
   let s:input_status = system("fcitx5-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx5-remote -c")
   endif
endfunction

function! Fcitx2zh()
   let s:input_status = system("fcitx5-remote")
   if g:input_toggle == 1
      let l:a = system("fcitx5-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=100
"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式
autocmd InsertEnter * call Fcitx2zh()
]])
