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
require("config.input_method").setup()
