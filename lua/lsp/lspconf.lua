local lspmoudle = {}

function lspmoudle.attach(client, bufnr)
	if client.server_capabilities.signatureHelpProvider then
		local fidget = require("fidget")
		local cmp = require("cmp")
		require("lsp_signature").on_attach(require("lsp.lspsignature").config, bufnr)
		cmp.event:on("menu_opened", function()
			vim.defer_fn(function()
				if
					_LSP_SIG_CFG.winnr ~= nil
					and _LSP_SIG_CFG.winnr ~= 0
					and vim.api.nvim_win_is_valid(_LSP_SIG_CFG.winnr)
				then
					vim.api.nvim_win_close(_LSP_SIG_CFG.winnr, true)
					_LSP_SIG_CFG.winnr = nil
					_LSP_SIG_CFG.bufnr = nil
					_LSP_SIG_CFG.floating_window = false
					fidget.notify("cmp started,enjoy it", nil, { annote = "signature", key = "foobar" })
				end
			end, 0)
		end)

		cmp.event:on("confirm_done", function()
			vim.defer_fn(function()
				--[[ if
			not (
				_LSP_SIG_CFG.winnr ~= nil
				and _LSP_SIG_CFG.winnr ~= 0
				and vim.api.nvim_win_is_valid(_LSP_SIG_CFG.winnr)
			)
		then ]]
				_LSP_SIG_CFG.floating_window = true
				require("lsp_signature").toggle_float_win()
				fidget.notify("open signature_help", nil, { annote = "signature", key = "foobar" })
			end, 0)
		end)
	end
	--- Guard against servers without the signatureHelper capability
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
	--[[ vim.keymap.set("n", "<M-h>", ":LspOverloadsSignature<CR>", { noremap = true, silent = true, buffer = bufnr })
	vim.keymap.set("i", "<M-h>", "<cmd>LspOverloadsSignature<CR>", { noremap = true, silent = true, buffer = bufnr }) ]]

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
