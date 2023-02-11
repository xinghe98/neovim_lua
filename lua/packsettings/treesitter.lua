require("nvim-treesitter.configs").setup {
	ensure_installed = { "c", "lua", "vim", "help","python","typescript","go","rust","json","yaml","html","css"
	,"javascript","bash","toml","regex","jsonc","graphql","vue","tsx","php","java","cpp","c_sharp",
	"ruby","dart","elixir","haskell","julia","kotlin",
	"ocaml","perl","query","r","scala","swift","verilog","vue","zig" },
	auto_install = true,
	ignore_install = { "markdown" },
  highlight = {
      -- ...
	  enable = true,
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
	colors = {
		'#e8b622',
		'#59dd5d',
		'#21a2ff',
		'#e669da',
		'#00D1c1',
		'#d65d0e',
		'#458588'

	}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
