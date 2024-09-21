-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
	'nvim-treesitter/nvim-treesitter',
	run = function()
	    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
	    ts_update()
	end,
    }

    use {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v3.x',
	requires = {
	    {'williamboman/mason.nvim'},
	    {'williamboman/mason-lspconfig.nvim'},
	    {'neovim/nvim-lspconfig'},
	    {'hrsh7th/nvim-cmp'},
	    {'hrsh7th/cmp-nvim-lsp'},
	    {'L3MON4D3/LuaSnip'},
	}
    }

    use {
	"folke/which-key.nvim",
    }

    use {
	"rrethy/vim-illuminate"
    }

    use {
	'shaunsingh/nord.nvim'
    }

    use {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	requires = {
	    "nvim-lua/plenary.nvim",
	    "MunifTanjim/nui.nvim",
	}
    }

end)
