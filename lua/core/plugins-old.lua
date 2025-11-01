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

return {
  -- themes
  {
    "catppuccin/nvim",                 -- or any colorscheme you prefer
    name = "catppuccin",
    priority = 1000,                    -- load before everything else
    config = function()
      require("core.plugin_config.colorscheme")
    end,
  },

  -- UI Helper
  {
    "folke/noice.nvim",
    event = "VeryLazy",                 -- load after UI is ready
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("core.plugin_config.noice")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("core.plugin_config.lualine")
    end,
  },
  {
    "nvim-mini/mini.nvim",
    name = "mini",
    config = function ()
      require("core.plugin_config.mini")
    end,
  },

  
  {
    "rmagatti/logger.nvim",
    name = "logger",
  },

  {
    "stevearc/oil.nvim"
    name = "oil",
    config = function()
      require("core.plugin_config.oil")
    end,
  },

}

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- themes
  use {
    'navarasu/onedark.nvim',
    'rebelot/kanagawa.nvim'
  }

  use 'rmagatti/logger.nvim'

  use 'stevearc/oil.nvim'

  use {
    'nvim-mini/mini.nvim',
    tag = false
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
    'ray-x/guihua.lua',
    'ray-x/go.nvim'
  }
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
  }
  use 'hrsh7th/nvim-cmp'
  use {
    'saghen/blink.cmp',
    requires = {
      'rafamadriz/friendly-snippets'
    },
    tag = '1.*',
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
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    }
  })

  use {
    'rest-nvim/rest.nvim',
    requires = {
      'nvim-treesitter/nvim-treesitter',
      'j-hui/fidget.nvim',
      'xml2lua/xml2lua',
      'luarocks/mimetypes'
    }
  }

  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
