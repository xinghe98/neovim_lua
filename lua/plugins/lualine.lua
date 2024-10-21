-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
	blue   = '#80a0ff',
	cyan   = '#79dac8',
	black  = '#080808',
	white  = '#c6c6c6',
	red    = '#ff5189',
	violet = '#FF7F24',
	grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = "" },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {

        options = {
          theme = bubbles_theme,
          globalstatus = true,
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
          },
          lualine_b = {
            "filename",

            {
              -- Lsp server name .
              function()
                local msg = "No Active Lsp"
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                  return msg
                end
                local servername = {}
                for k, client in ipairs(clients) do
                  local filetypes = client.config.filetypes
                  if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    servername[k] = client.name
                  end
                end
                return table.concat(servername, ", ")
              end,
              icon = " LSP:",
              color = { fg = "#ffffff", gui = "bold" },
            },
            --[[ {
				function()
					-- invoke `progress` here.
					return require("lsp-progress").progress()
				end,
			}, ]]
            {

              function()
                local luasnip = require("luasnip")
                if luasnip.expand_or_jumpable() then
                  return "snippetting" .. " 😉"
                end
                return ""
              end,
            },
            {
              function()
                return vim.g.flutter_tools_decorations.device
              end,
            },
            {

              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " " },
              diagnostics_color = {
                color_error = { fg = colors.red },
                color_warn = { fg = colors.yellow },
                color_info = { fg = colors.cyan },
              },
            },
          },
          lualine_c = {},
          lualine_x = {
            {

              "diff",
              -- Is it me or the symbol for modified us really weird
              symbols = { added = " ", modified = " ", removed = " " },
              diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
              },
            },
          },
          lualine_y = {
            "branch",
            "filetype",
            "progress",
          },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "lazy", "nvim-tree" },
        --[[add your custom lualine config here]]
      }
    end,
  },
}
