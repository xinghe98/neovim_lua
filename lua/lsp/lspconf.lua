local function attach(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- 跳转到定义（代替内置 LSP 的窗口，telescope 插件让跳转定义更方便）
	vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions theme=dropdown<CR>", bufopts)
	-- 列出光标下所有引用（代替内置 LSP 的窗口，telescope 插件让查看引用更方便）
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>", bufopts)
	-- 工作区诊断（代替内置 LSP 的窗口，telescope 插件让工作区诊断更方便）
	-- vim.keymap.set("n", "gg", "<cmd>Telescope diagnostics theme=dropdown<CR>", bufopts)
	-- 显示代码可用操作（代替内置 LSP 的窗口，telescope 插件让代码行为更方便）
	vim.keymap.set("n", "<A-a>", "<cmd>Lspsaga code_action<CR>", bufopts)
	-- 变量重命名（代替内置 LSP 的窗口，Lspsaga 让变量重命名更美观）
	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", bufopts)
	-- 查看帮助信息（代替内置 LSP 的窗口，Lspsaga 让查看帮助信息更美观）
	vim.keymap.set("n", "gh", "<cmd>Lspsaga hover_doc<CR>", bufopts)
	-- 跳转到上一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
	vim.keymap.set("n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
	-- 跳转到下一个问题（代替内置 LSP 的窗口，Lspsaga 让跳转问题更美观）
	vim.keymap.set("n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
	-- 悬浮窗口上翻页，由 Lspsaga 提供
	vim.keymap.set("n", "<c-p>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", bufopts)
	-- 悬浮窗口下翻页，由 Lssaga 提供
	vim.keymap.set("n", "<c-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", bufopts)
	-- 显示错误信息（代替内置 LSP 的窗口）
	vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	vim.keymap.set("v", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	-- ** auto format when saving a file **
	-- ** if need this, plz enable it mannually. **
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*",
		callback = function(args)
			require("conform").format({ async = true, lsp_fallback = true, buf = args.buf }, function(err)
				if not err then
					vim.api.nvim_buf_call(args.buf, function()
						vim.cmd.update()
					end)
				end
			end)
		end,
	})
	-- ** (don't forget the 'conf/rust-tools-conf.lua) **
	vim.api.nvim_create_autocmd("InsertEnter", {
		pattern = "*",
		callback = function(args)
			require("conform").format({ buf = args.buf })
		end,
	})
	--[[ vim.api.nvim_create_autocmd('BufWritePre', {
		group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ async = false })
		end
	}) ]]
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			on_attach = attach,
			capabilities = capabilities,
		})
		--[[ require "lsp_signature".on_attach({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			handler_opts = {
				border = "rounded"
			}
		}, bufnr) ]]
		require("lsp_signature").setup({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			handler_opts = {
				border = "rounded",
			},
		})
	end,
})
