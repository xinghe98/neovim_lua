return {
	"nvim-telescope/telescope.nvim",
	-- replace all Telescope keymaps with only one mapping

	-- dependencies = { 'nvim-telescope/telescope-ui-select.nvim' },
	--
	keys = function()
		return {
			{ "<C-f>",      "<cmd>Telescope find_files<cr>",   desc = "Find Files" },
			{ "<C-g>",      "<cmd>Telescope live_grep<cr>",    desc = "Find Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>",      desc = "Find buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>",    desc = "Find help" },
			{ "<C-x>",      ":Telescope flutter commands<CR>", desc = "flutter" },
		}
	end,
	opts = {
		defaults = {
			sorting_strategy = "ascending",
			prompt_prefix = "🔍 ", -- 改变提示符样式
			selection_caret = "> ", -- 改变选项前面的符号
			entry_prefix = "  ", -- 删除不需要的符号
			color_devicons = true, -- 启用或禁用图标颜色
			file_ignore_patterns = {
				"%.env",
				"yarn.lock",
				"package-lock.json",
				"lazy-lock.json",
				"init.sql",
				"target/.*",
				".git/.*",
				-- "node_modules",
				"dist",
			},
			mappings = {
				i = {
					-- map actions.which_key to <C-h> (default: <C-/>)
					-- actions.which_key shows the mappings for your picker,
					-- e.g. git_{create, delete, ...}_branch for the git_branches picker
					["<Tab>"] = "move_selection_next",
					["<S-Tab>"] = "move_selection_previous",
					["<C-u>"] = "preview_scrolling_up",
					["<C-e>"] = "preview_scrolling_down",
				},
			},
		},
	},
	-- config = function(_, opts)
	-- 	-- 将 opts 传递给 telescope 的 setup
	-- 	require("telescope").setup(opts)
	-- 	-- 配置 ui-select 扩展
	-- 	--
	-- 	require("telescope").setup {
	-- 		extensions = {
	-- 			["ui-select"] = {
	-- 				require("telescope.themes").get_cursor {
	-- 					width = 0.4,
	-- 					winblend = 0,
	-- 				}
	-- 			}
	-- 		}
	-- 	}
	-- 	-- 确保在 setup 后加载 ui-select 扩展
	-- 	vim.defer_fn(function()
	-- 		require("telescope").load_extension("ui-select")
	-- 	end, 50) -- 50ms 延迟加载 ui-select 扩展
	-- end,
}
