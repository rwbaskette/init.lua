-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }

  use {
      'fatih/vim-go',
      run = ':GoUpdateBinaries'
  }


  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment the two plugins below if you want to manage the language servers from neovim
       {'williamboman/mason.nvim'},
       {'williamboman/mason-lspconfig.nvim'},

       {'L3MON4D3/LuaSnip'},
       {'hrsh7th/cmp-buffer'},
       {'hrsh7th/cmp-nvim-lsp'},
       {'hrsh7th/cmp-path'},
       {'hrsh7th/nvim-cmp'},
       {'neovim/nvim-lspconfig'},

       {'saadparwaiz1/cmp_luasnip'},
       {'hrsh7th/cmp-nvim-lua'},
       {'L3MON4D3/LuaSnip'},
       {'rafamadriz/friendly-snippets'},
    }
  }

	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	use 'preservim/nerdcommenter'

        use 'letorbi/vim-colors-modern-borland'
end)
