return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufEnter",
    main = "ibl",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
    },
    opts = {
      scope = { enabled = false },
    },
    --[[ config = function()
			require("packsettings.indentline")
		end, ]]
  },
  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = "BufRead", -- 事件触发插件加载
    opts = {
      mappings = {
        -- Textobjects
        object_scope = "",
        object_scope_with_border = "",

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = "[t",
        goto_bottom = "]t",
      },
      symbol = "┃", -- 缩进线的符号lp
      options = { try_as_border = true }, -- 配置项
    },
    init = function()
      -- 禁用特定文件类型的缩进高亮
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "lazy",
          "mason",
          "neo-tree",
          "Trouble",
          "toggleterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
