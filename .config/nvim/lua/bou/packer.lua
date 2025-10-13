-- .config/nvim/lua/bou/packer.lua
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Existing plugins
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/playground')
    
    -- Colorschemes
    use("olimorris/onedarkpro.nvim")
    use("rebelot/kanagawa.nvim")
    use("rose-pine/neovim")
    use("thesimonho/kanagawa-paper.nvim")

    use('theprimeagen/harpoon')
    use("mbbill/undotree")
    use('tpope/vim-fugitive')
    
    -- LSP Support
    use {
        'neovim/nvim-lspconfig',             -- Required for LSP
        'williamboman/mason.nvim',           -- Optional
        'williamboman/mason-lspconfig.nvim', -- Optional
    }
    
    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',         -- The completion plugin
        'hrsh7th/cmp-buffer',       -- buffer completions
        'hrsh7th/cmp-path',         -- path completions
        'hrsh7th/cmp-cmdline',      -- cmdline completions
        'saadparwaiz1/cmp_luasnip', -- snippet completions
        'hrsh7th/cmp-nvim-lsp',     -- LSP completions
        'hrsh7th/cmp-nvim-lua',     -- Lua completions for Neovim API
    }
    
    -- Snippets
    use {
        'L3MON4D3/LuaSnip',             -- Snippet engine
        'rafamadriz/friendly-snippets',  -- Snippet collection
    }
    
    -- File Explorer (NvimTree instead of NERDTree)
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }
    
    -- Terminal integration
    
    -- Lualine (status line)
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    
    -- Autopairs
    use {
        "windwp/nvim-autopairs",
    }
    
    -- Comment toggle
    use {
        'numToStr/Comment.nvim',
    }
    
    -- Indent blankline (updated to v3)
    use {
        "lukas-reineke/indent-blankline.nvim",
    }
    
    -- Git signs in the gutter
    use {
        'lewis6991/gitsigns.nvim',
    }
end)
