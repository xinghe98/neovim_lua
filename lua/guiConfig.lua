vim.cmd([[
if exists("g:neovide")
	set guifont=Consolas_NF:h16
	let g:neovide_transparency = 0.8
	let g:transparency = 0.8
	let g:neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))
endif
]])
