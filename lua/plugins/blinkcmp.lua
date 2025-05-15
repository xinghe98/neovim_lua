local setCompHL = function()
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#9FBD73", bg = "NONE", bold = true })
  -- vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "white", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = "#7e8294" })
  vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = "#808080", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = "#7e8294", bg = "NONE" })
  vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#7e8294", bg = "NONE" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = "#B5585F" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = "#B5585F" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindEvent", { fg = "#B5585F" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", { fg = "#9FBD73" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = "#9FBD73" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { fg = "#D4BB6C" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindReference", { fg = "#D4BB6C" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = "#A377BF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", { fg = "#A377BF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = "#A377BF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = "#A377BF" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { fg = "#A377BF" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = "#58B5A8" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindUnit", { fg = "#D4A959" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = "#D4A959" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { fg = "#D4A959" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindValue", { fg = "#6C8ED4" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", { fg = "#6C8ED4" })

  vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { fg = "#58B5A8" })
  vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", { fg = "#58B5A8" })
end
setCompHL()
return {
  "saghen/blink.cmp",

  dependencies = {
    { "onsails/lspkind.nvim" },
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    },
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  opts = {
    snippets = {
      preset = "luasnip",
      --INFO: 避免dartls补全占位符的问题
      expand = function(args)
        require("luasnip").lsp_expand(args)
      end,
    },
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
      ["<C-e>"] = { "scroll_documentation_down", "snippet_forward" },
      ["<C-u>"] = { "scroll_documentation_up", "snippet_backward" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<ESC>"] = { "cancel", "fallback" },
    },
    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },
    signature = {
      enabled = true,
      trigger = {
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        -- When true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true,
      },
      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
        -- Which directions to show the window,
        -- falling back to the next direction when there's not enough space,
        -- or another window is in the way
        direction_priority = { "n", "s" },
        -- Disable if you run into performance issues
        treesitter_highlighting = true,
      },
    },
    completion = {
      ghost_text = { enabled = false },
      trigger = {
        show_on_insert_on_trigger_character = true,
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
          direction_priority = {
            menu_north = { "w", "e", "n", "s" },
            menu_south = { "w", "e", "s", "n" },
          },
        },
      },
      list = {
        -- Maximum number of items to display
        max_items = 200,
        -- Controls if completion items will be selected automatically,
        -- and whether selection automatically inserts
        selection = { preselect = false, auto_insert = false },
        -- Controls how the completion items are selected
        -- 'preselect' will automatically select the first item in the completion list
        -- 'manual' will not select any item by default
        -- 'auto_insert' will not select any item by default, and insert the completion items automatically
        -- when selecting them
        --
        -- You may want to bind a key to the `cancel` command, which will undo the selection
        -- when using 'auto_insert'
        cycle = {
          -- When `true`, calling `select_next` at the *bottom* of the completion list
          -- will select the *first* completion item.
          from_bottom = true,
          -- When `true`, calling `select_prev` at the *top* of the completion list
          -- will select the *last* completion item.
          from_top = true,
        },
      },
      menu = {
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", "label_description", "source_name", gap = 1 }, { "kind" } },
          components = {
            label = {
              ellipsis = true,
              width = { fill = true, max = 50 },
              text = function(ctx)
                return ctx.label .. ctx.label_detail
              end,
              highlight = function(ctx)
                -- label and label details
                local highlights = {
                  { 0, #ctx.label, group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel" },
                }
                if ctx.label_detail then
                  table.insert(
                    highlights,
                    { #ctx.label, #ctx.label + #ctx.label_detail, group = "BlinkCmpLabelDetail" }
                  )
                end

                -- -- characters matched on the label by the fuzzy matcher
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                end

                return highlights
              end,
            },
            label_description = {
              width = { max = 50 },
              text = function(ctx)
                if ctx.item.detail ~= nil and ctx.item.detail ~= "" and #ctx.item.detail <= 65 then
                  return ctx.item.detail
                end
                if ctx.label_description ~= "" and ctx.label_description ~= nil then
                  return ctx.label_description
                end
              end,
              highlight = "BlinkCmpLabelDescription",
            },
            source_name = {
              width = { max = 10 },
              -- source_name or source_id are supported
              text = function(ctx)
                return ({
                  LSP = "🎮",
                  Snippets = "🛟",
                  Buffer = "💊",
                  Path = "📂",
                })[ctx.source_name]
              end,
              highlight = "BlinkCmpLabel",
            },
            kind = {
              text = function(ctx)
                return "<" .. ctx.kind .. ">"
              end,
              highlight = "BlinkCmpKind",
            },
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                require("lspkind").init({
                  mode = "symbol",
                  symbol_map = {
                    Text = "󰓽",
                    Method = "m",
                    Function = "󰊕",
                    Constructor = " ",
                    Field = " ",
                    Variable = "󰫧 ",
                    Class = " ",
                    Interface = "󱇰 ",
                    Module = " ",
                    Property = "󰀔 ",
                    Unit = " ",
                    Value = "󱀍 ",
                    Keyword = "󰌆",
                    Snippet = "󰩫",
                    Color = " ",
                    File = " ",
                    Reference = " ",
                    Folder = " ",
                    Enum = " ",
                    Constant = " ",
                    Struct = "  ",
                    Event = " ",
                    Operator = " ",
                    TypeParameter = "󰉺 ",
                    Default = "󰊨 ",
                  },
                })
                return require("lspkind").symbolic(ctx.kind, {
                  mode = "symbol",
                })
              end,
            },
          },
        },
      },
    },
  },
}
