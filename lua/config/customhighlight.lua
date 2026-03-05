vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#888888", bg = "none", italic = false })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { bg = "NONE", fg = "#BCEE68", bold = true })
vim.api.nvim_set_hl(0, "CurrentWord", {
  bg = "#696969", -- 你的浅灰色
  fg = "NONE", -- 保持前景(文字)颜色不变
  bold = false,
})
vim.api.nvim_set_hl(0, "LspReferenceText", {
  -- bg = "#696969", -- 你的浅灰色
  bg = "NONE", -- 你的浅灰色
  fg = "NONE", -- 保持前景(文字)颜色不变
  bold = false,
})
vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceText" })
-- vim.api.nvim_set_hl(0, "LspReferenceWrite", { link = "LspReferenceText" })
