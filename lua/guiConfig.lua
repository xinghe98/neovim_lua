if vim.g.neovide then
	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_transparency = 0.5
	vim.g.transparency = 0.5
	-- vim.g.neovide_background_color = "#0f1117" .. alpha()
	vim.o.guifont = "Monaco_Nerd_Font:h19"
	vim.g.neovide_window_blurred = true
	-- Put anything you want to happen only in Neovide here
end
