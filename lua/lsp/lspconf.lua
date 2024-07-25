local lspmoudle = {}

function lspmoudle.attach(client, bufnr)
	--- Guard against servers without the signatureHelper capability
	if client.server_capabilities.signatureHelpProvider then
		require("lsp-overloads").setup(client, {
			-- UI options are mostly the same as those passed to vim.lsp.util.open_floating_preview
			ui = {
				border = "single", -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
				height = nil, -- Height of the signature popup window (nil allows dynamic sizing based on content of the help)
				width = nil, -- Width of the signature popup window (nil allows dynamic sizing based on content of the help)
				wrap = true, -- Wrap long lines
				wrap_at = nil, -- Character to wrap at for computing height when wrap enabled
				max_width = 80, -- Maximum signature popup width
				max_height = nil, -- Maximum signature popup height
				-- Events that will close the signature popup window: use {"CursorMoved", "CursorMovedI", "InsertCharPre"} to hide the window when typing
				close_events = { "CursorMoved", "BufHidden", "InsertLeave", "CursorMovedI", "InsertCharPre" },
				focusable = true, -- Make the popup float focusable
				focus = false, -- If focusable is also true, and this is set to true, navigating through overloads will focus into the popup window (probably not what you want)
				offset_x = 0, -- Horizontal offset of the floating window relative to the cursor position
				offset_y = 0, -- Vertical offset of the floating window relative to the cursor position
				floating_window_above_cur_line = false, -- Attempt to float the popup above the cursor position
				-- (note, if the height of the float would be greater than the space left above the cursor, it will default
				-- to placing the float below the cursor. The max_height option allows for finer tuning of this)
				silent = true, -- Prevents noisy notifications (make false to help debug why signature isn't working)
				-- Highlight options is null by default, but this just shows an example of how it can be used to modify the LspSignatureActiveParameter highlight property
				highlight = {
					italic = true,
					bold = true,
					fg = "#ffffff",
					-- Other options accepted by the `val` parameter of vim.api.nvim_set_hl()
				},
			},
			keymaps = {
				-- next_signature = "<C-j>",
				-- previous_signature = "<C-k>",
				-- next_parameter = "<C-l>",
				-- previous_parameter = "<C-h>",
				close_signature = "<M-h>",
			},
			display_automatically = true, -- Uses trigger characters to automatically display the signature overloads when typing a method signature
		})
	end
	local bufopts = { noremap = true, silent = true }

	-- 跳转到定义（代替内置 LSP 的窗口，telescope 插件让跳转定义更方便）
	vim.keymap.set("n", "gd", ":Telescope lsp_definitions theme=dropdown<CR>", bufopts)
	-- 列出光标下所有引用（代替内置 LSP 的窗口，telescope 插件让查看引用更方便）
	vim.keymap.set("n", "gr", ":Telescope lsp_references theme=dropdown<CR>", bufopts)
	-- 工作区诊断（代替内置 LSP 的窗口，telescope 插件让工作区诊断更方便）
	vim.keymap.set("n", "<leader>g", ":Telescope diagnostics theme=dropdown<CR>", bufopts)
	-- 显示代码可用操作（代替内置 LSP 的窗口，telescope 插件让代码行为更方便）
	vim.keymap.set("n", "<M-a>", ":Lspsaga code_action<CR>", bufopts)
	-- 变量重命名（代替内置 LSP 的窗口，Lspsaga 让变量重命名更美观）
	vim.keymap.set("n", "<leader>rn", ":Lspsaga rename<CR>", bufopts)
	-- 查看帮助信息（代替内置 LSP 的窗口，Lspsaga 让查看帮助信息更美观）
	vim.keymap.set("n", "gh", ":Lspsaga hover_doc<CR>", bufopts)
	-- 跳转到上一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
	vim.keymap.set("n", "g[", ":Lspsaga diagnostic_jump_prev<CR>", bufopts)
	-- 跳转到下一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
	vim.keymap.set("n", "g]", ":Lspsaga diagnostic_jump_next<CR>", bufopts)
	vim.keymap.set("n", "<leader>e", ":Lspsaga show_line_diagnostics<CR>", bufopts)
	vim.keymap.set("n", "<M-h>", ":LspOverloadsSignature<CR>", { noremap = true, silent = true, buffer = bufnr })
	vim.keymap.set("i", "<M-h>", "<cmd>LspOverloadsSignature<CR>", { noremap = true, silent = true, buffer = bufnr })

	-- ** (don't forget the 'conf/rust-tools-conf.lua) **
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		callback = function(args)
			require("conform").format({ lsp_fallback = true, buf = args.buf })
		end,
	})
end

-- Add additional capabilities supported by nvim-cmp

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = lspmoudle.attach,
			capabilities = capabilities,
		})
	end,
})
return lspmoudle
