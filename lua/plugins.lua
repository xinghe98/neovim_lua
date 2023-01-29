vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
use 'wbthomason/packer.nvim'
-- lsp config
use {
        'williamboman/mason.nvim',
        config = function()
            require('lsp/mason')
        end
    }
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use {'hrsh7th/nvim-cmp',config = function() require('lsp.cmp') end}
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'rafamadriz/friendly-snippets' -- Snippets (vscode-like) collection for different languages
    use {
        'L3MON4D3/LuaSnip', -- Snippets plugin
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    }
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-look'
    use 'f3fora/cmp-spell'
	use {
	'tami5/lspsaga.nvim',
	config = function()
		require('lsp/lspsaga')
	end
}
--------lsp end -------------------
use {'rcarriga/nvim-notify',config = function() require('packsettings.notify') end}
use {
  'mrded/nvim-lsp-notify',
  config = function()
    require('lsp-notify').setup({})
  end
}
use 'mhinz/vim-startify'
use 'theniceboy/nvim-deus'
use 'folke/tokyonight.nvim'
use 'sainnhe/gruvbox-material'
use {'liuchengxu/vista.vim',config = function() require('packsettings.vista') end}
use 'h-hg/fcitx.nvim'
use {'mg979/vim-visual-multi',branch='master'}
use 'posva/vim-vue'
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
use 'roxma/nvim-yarp'
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  config = function() require('packsettings.nvimtree') end,
  tag = 'nightly' -- optional, updated every week. (see issue #1193)
}
use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  config = function() require('packsettings.lualine') end
}
use 'voldikss/vim-translator'
use 'tpope/vim-surround'
use 'itchyny/vim-cursorword'
use 'Yggdroot/indentLine'
use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}
use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons',
config = function() require('packsettings.bufferline') end}
use 'tell-k/vim-autopep8'
-- 快速注释
use {'b3nj5m1n/kommentary', config = function() require('packsettings.kommentary') end}
use 'yuezk/vim-js'
-- 终端悬浮窗
use 'voldikss/vim-floaterm'
-- 文件搜索插件
use 'nvim-lua/plenary.nvim'
use {'nvim-telescope/telescope.nvim',tag ='0.1.1',
requires = {
            "nvim-lua/plenary.nvim", -- Lua 开发模块
            "BurntSushi/ripgrep", -- 文字查找
            "sharkdp/fd" -- 文件查找
        },
config = function() require('packsettings.telescope') end}
-- Markdown
use {'iamcco/markdown-preview.nvim'}
use 'dhruvasagar/vim-table-mode'
use 'mzlogin/vim-markdown-toc'
use {'dkarter/bullets.vim', config = function() require('packsettings.bullets') end}
use {'fatih/vim-go', run = ':GoUpdateBinaries',config = function() require('packsettings.vimgo') end}
require('packsettings/copilot').config()
use { 'github/copilot.vim', config = "require('packsettings/copilot').setup()", event = 'InsertEnter' }
use 'godlygeek/tabular'
  -- 你可以在这里定义你所需要的插件列表
end)
