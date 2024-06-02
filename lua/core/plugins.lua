local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- themes
  use {
    'navarasu/onedark.nvim',
    'rebelot/kanagawa.nvim'
  }

  use 'folke/noice.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
  }
  use 'nvim-lualine/lualine.nvim'
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig'
  }
  use 'MunifTanjim/nui.nvim'
  use 'rcarriga/nvim-notify'
  use {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    require = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {}
    end
  }
  -- go setup
  use {
    'vim-test/vim-test',
    'fatih/vim-go',
    'ray-x/guihua.lua',
    'ray-x/go.nvim'
  }
  --use 'ray-x/go.nvim'
  -- rust setup
  use {
    'simrat39/rust-tools.nvim'
  }
  use 'kdheepak/lazygit.nvim'
  -- complete setup
  use {
    'hrsh7th/cmp-nvim-lsp',
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
  }
  use {
  'hrsh7th/nvim-cmp',
  config = function ()
    require'cmp'.setup {
      snippet = {
        expand = function(args)
          require'luasnip'.lsp_expand(args.body)
        end
      },

      sources = {
        { name = 'luasnip' },
        -- more sources
      },
    }
    end
  }
  use {'L3MON4D3/LuaSnip'} -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets
  use("ramilito/kubectl.nvim")
  use("ThePrimeagen/harpoon")
  use {
    "rcarriga/nvim-dap-ui",
    requires = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "folke/neodev.nvim"
    }
  }
  use("mfussenegger/nvim-dap")
  use("theHamsta/nvim-dap-virtual-text")
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
