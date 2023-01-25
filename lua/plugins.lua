vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  -- 
use 'wbthomason/packer.nvim'
use 'mhinz/vim-startify'
use 'theniceboy/nvim-deus'
use 'sainnhe/gruvbox-material'
use 'liuchengxu/vista.vim'
use 'rcarriga/nvim-notify'
use 'h-hg/fcitx.nvim'
use {'mg979/vim-visual-multi',branch='master'}
use 'posva/vim-vue'
use 'rakr/vim-one'
use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
use 'roxma/nvim-yarp'
use {'windwp/windline.nvim', config = function() require('wlsample.wind') end}
use 'voldikss/vim-translator'
use 'tpope/vim-surround'
use 'itchyny/vim-cursorword'
use 'Yggdroot/indentLine'
use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
use {'neoclide/coc.nvim' , branch = 'release' }
use 'jiangmiao/auto-pairs'
use 'tell-k/vim-autopep8'
use 'scrooloose/nerdcommenter'
use 'yuezk/vim-js'
-- 终端悬浮窗
use 'voldikss/vim-floaterm'
-- 文件搜索插件
use 'nvim-lua/plenary.nvim'
use {'nvim-telescope/telescope.nvim',tag ='0.1.1' }
-- Markdown
use {'iamcco/markdown-preview.nvim'}
use 'dhruvasagar/vim-table-mode'
use 'mzlogin/vim-markdown-toc'
use 'dkarter/bullets.vim'
require('packsettings.vimgo')
use 'fatih/vim-go'
require('packsettings/copilot').config()
use { 'github/copilot.vim', config = "require('packsettings/copilot').setup()", event = 'InsertEnter' }
use 'godlygeek/tabular'

  -- 你可以在这里定义你所需要的插件列表
end)
