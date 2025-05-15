return {
  "folke/noice.nvim",
  keys = function()
    return {
      { "K", false },
    }
  end,
  opts = {
    routes = {
      {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = {
          skip = true,
        },
      },
      {
        filter = {
          event = "notify",
          find = "marksman",
        },
        opts = {
          skip = true,
        },
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    views = {
      mini = {
        win_options = {
          winblend = 0,
        },
      },
    },
    popupmenu = {
      enabled = true, -- enables the Noice popupmenu UI
      ---@type 'nui'|'cmp'
      backend = "nui", -- backend to use to show regular cmdline completions
      -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
      kind_icons = {}, -- set to `false` to disable icons
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true, -- enables the Noice messages UI
      -- view = "mini", -- default view for messages
      -- view_error = "notify", -- view for errors
      -- view_warn = "mini", -- view for warnings
      -- view_history = "messages", -- view for :messages
      -- view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    lsp = {
      hover = {
        -- Set not show a message if hover is not available
        -- ex: shift+k on Typescript code
        silent = true,
      },
      documentation = {
        view = "hover",
        opts = {
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          win_options = { concealcursor = "n", conceallevel = 3 },
        },
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = false,
          trigger = false, -- Automatically show signature help when typing a trigger character from the LSP
          luasnip = false, -- Will open signature help when jumping to Luasnip insert nodes
          throttle = 50, -- Debounce lsp signature help request by 50ms
        },
        view = nil, -- when nil, use defaults from documentation
        ---@type NoiceViewOptions
        opts = {}, -- merged with defaults from documentation
      },
    },
  },
}
