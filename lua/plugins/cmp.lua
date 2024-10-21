local setCompHL = function()
  local fgdark = "#2E3440"

  vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "Float", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "lspInlayHint", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })

  vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080", bg = "NONE", italic = true })
  vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = fgdark, bg = "#B5585F" })
  vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = fgdark, bg = "#B5585F" })
  vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = fgdark, bg = "#B5585F" })

  vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fgdark, bg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = fgdark, bg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = fgdark, bg = "#9FBD73" })

  vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = fgdark, bg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = fgdark, bg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = fgdark, bg = "#D4BB6C" })

  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = fgdark, bg = "#A377BF" })
  vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = fgdark, bg = "#A377BF" })

  vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = fgdark, bg = "#7E8294" })
  vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = fgdark, bg = "#7E8294" })

  vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = fgdark, bg = "#D4A959" })
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = fgdark, bg = "#D4A959" })
  vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = fgdark, bg = "#D4A959" })

  vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = fgdark, bg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = fgdark, bg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = fgdark, bg = "#6C8ED4" })

  vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = fgdark, bg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = fgdark, bg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = fgdark, bg = "#58B5A8" })
end
local limitStr = function(str)
  if #str > 25 then
    str = string.sub(str, 1, 22) .. "..."
  end
  return str
end
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
return {
  {
    "L3MON4D3/LuaSnip", -- Snippets plugin
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "~/.local/share/nvim/lazy/friendly-snippets/snippets" },
      })
      -- require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  },
  { "onsails/lspkind.nvim" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { { "hrsh7th/cmp-emoji" }, { "saadparwaiz1/cmp_luasnip" } },
    config = function()
      require("lspkind").init({
        symbol_map = {
          text = "󰓽 Text",
          method = "m Method",
          Function = "󰊕 Func",
          constructor = " Constructor",
          field = " Field",
          variable = "󱄑 Variable",
          class = " Class",
          interface = " Interface",
          module = " Module",
          property = "󰀔 Property",
          unit = " Unit",
          value = "󱀍 Value",
          keyword = "󰌆 Keyword",
          snippet = " Snippet",
          color = " Color",
          file = " File",
          reference = " Reference",
          folder = " Folder",
          enum = " Enummember",
          constant = " Constant",
          struct = "  Struct",
          event = " Event",
          operator = " Operator",
          typeParameter = "󰉺 TypeParameter",
          default = "󰊨 default",
        },
      })

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      setCompHL()
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp", keyword_length = 2, priority = 100 },
          { name = "buffer", keyword_length = 3, priority = 60 },
          { name = "path", keyword_length = 3, priority = 90 },
          { name = "nvim_lua", keyword_length = 3, priority = 50 },
          { name = "look", keyword_length = 3, priority = 40 },
          {
            name = "spell",
            option = {
              keyword_length = 4,
              keep_all_entries = true,
              enable_in_context = function()
                return true
              end,
            },
            priority = 40,
          },
          { name = "luasnip", keyword_length = 3, priority = 10 },
          { name = "calc", priority = 5 },
        },
        window = {
          completion = cmp.config.window.bordered({
            border = { "", "─", "╮", "│", "󱡻", "─", "╰", "│" },
          }),
          scrollbar = false,
          --[[ completion = {
			-- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		}, ]]
          documentation = cmp.config.window.bordered(),
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        },
        completion = { completeopt = "noselect", keyword_length = 1 },
        preselect = cmp.PreselectMode.none,
        mapping = cmp.mapping.preset.insert({
          --[[ ["<C-u>"] = cmp.mapping.select_prev_item(),
		["<C-e>"] = cmp.mapping.select_next_item(), ]]
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-e>"] = cmp.mapping.scroll_docs(4),
          ["<C-q>"] = cmp.mapping.abort(),
          -- ["<Esc>"] = cmp.mapping.abort(),
          -- TODO: potentially fix emmet nonsense
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
              else
                fallback()
              end
            end,
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          expandable_indicator = true,
          format = function(entry, vim_item)
            -- Kind icons
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            vim_item.kind = " " .. (strings[1] or "") .. " "
            -- local name = entry.source.name
            if entry.completion_item.detail ~= nil then
              vim_item.menu = " " .. (strings[2] or "") .. ":" .. " " .. limitStr(entry.completion_item.detail or "")
            else
              vim_item.menu = " " .. (strings[2] or "")
            end
            local widths = {
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }
            for key, width in pairs(widths) do
              if vim_item[key] and vim.fn.strdisplaywidth(vim_item[key]) > width then
                vim_item[key] = vim.fn.strcharpart(vim_item[key], 0, width - 1) .. "…"
              end
            end
            return vim_item
          end,
        },
      })
    end,
  },
}
