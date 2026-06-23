-- LSP 悬浮提示
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#888888", bg = "none", italic = false })

-- 补全菜单匹配高亮
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { bg = "NONE", fg = "#BCEE68", bold = true })

-- 状态栏透明
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "NONE" })

-- 当前词高亮
vim.api.nvim_set_hl(0, "CurrentWord", {
  bg = "#696969",
  fg = "NONE",
  bold = false,
})

-- LSP 参考高亮
vim.api.nvim_set_hl(0, "LspReferenceText", {
  bg = "NONE",
  fg = "NONE",
  bold = false,
})
vim.api.nvim_set_hl(0, "LspReferenceRead", { link = "LspReferenceText" })

-- 窗口分割线
local fillchars = vim.opt.fillchars:get()
fillchars.vert = "│"
fillchars.horiz = "─"
fillchars.vertleft = "┤"
fillchars.vertright = "├"
fillchars.verthoriz = "┼"
fillchars.horizup = "┴"
fillchars.horizdown = "┬"
vim.opt.fillchars = fillchars

-- Avante 边框透明
vim.api.nvim_set_hl(0, "AvantePanelBorder", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "AvanteBorder", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "AvanteSidebarBorder", { fg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#4b5563", bg = "NONE" })

local function set_float_transparent_hl()
  local groups = {
    "NormalFloat",
    "FloatBorder",
    "BlinkCmpDoc",
    "BlinkCmpMenu",
    "BlinkCmpSignatureHelp",
    "BlinkCmpDocBorder",
    "BlinkCmpSignatureHelpBorder",
    "SnacksPicker",
    "SnacksPickerInput",
    "SnacksPickerList",
    "SnacksPickerPreview",
    "SnacksPickerBorder",
    "SnacksInput",
    "SnacksInputBorder",
  }

  for _, group in ipairs(groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
    vim.api.nvim_set_hl(0, group, { fg = ok and hl.fg or nil, bg = "NONE", ctermbg = "NONE" })
  end
end

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter", "UIEnter", "WinNew" }, {
  group = vim.api.nvim_create_augroup("custom_float_transparent_hl", { clear = true }),
  callback = function()
    vim.schedule(set_float_transparent_hl)
  end,
})

set_float_transparent_hl()
vim.defer_fn(set_float_transparent_hl, 100)
vim.defer_fn(set_float_transparent_hl, 500)
