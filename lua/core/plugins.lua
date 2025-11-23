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

  {
    "rebelot/kanagawa.nvim"
  },

  -- UI Helper
  {
    "folke/noice.nvim",
    event = "VeryLazy",                 -- load after UI is ready
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("core.plugin_config.noice")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("core.plugin_config.lualine")
    end,
  },
  {
    "nvim-mini/mini.nvim",
    name = "mini",
    version = false,
    config = function ()
      require("core.plugin_config.mini")
    end,
  },

  {
    "rmagatti/logger.nvim",
    name = "logger",
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "folke/neodev.nvim"
    },
  },

  -- Synthax / parsing

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
      require("core.plugin_config.nvim-treesitter")
    end,
  },

  -- LSP / completions

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function ()
      require("core.plugin_config.mason")
    end
  },

  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason-lspconfig",
      "jose-elias-alvarez/null-ls.nvim"
    },
    config = function ()
      require("core.plugin_config.lsp_config")
    end
  },

  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
  },

  {
    "saadparwaiz1/cmp_luasnip",
    name = "luasnip"
  },

  -- Telescope

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      { "nvim-lua/plenary.nvim" }
    },
    config =  function ()
      require("core.plugin_config.telescope")
    end
  },


  -- Navigation

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    config = function()
      require("core.plugin_config.neotree")
    end,
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = {
      {"nvim-mini/mini.icons"}
    },
    config = function()
      require("core.plugin_config.oil")
    end,
  },



  -- Languages plugins

    -- GO
  {
    "ray-x/go.nvim",
    ft = "go",
    dependencies = {
      "vim-test/vim-test",
      "ray-x/guihua.lua"
    },
    config = function ()
      require("core.plugin_config.go")
    end
  },

    -- rust
  {
    "simrat39/rust-tools.nvim",
    ft = "rust"
  },

  -- DAP

  {
   "mfussenegger/nvim-dap",
   event = "VeryLazy",
   config = function ()
     require("core.plugin_config.dap")
   end
  },

  -- Miscelaneous
  {
    "kdheepak/lazygit.nvim",
    name = "lazygit"
  },

  {
    "rmagatti/goto-preview",
    config = function ()
      require("core.plugin_config.goto")
    end
  },

  {
    "ThePrimeagen/harpoon",
    name = "harpoon"
  },

  {
    "L3MON4D3/LuaSnip",
    cmd = "Lua"
  },

  {
    "theHamsta/nvim-dap-virtual-text"
  },

  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function (_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    },
  },
  {
    "saxon1964/neovim-tips",
    version = "*", -- Only update on tagged releases
    lazy = false,  -- Load on startup (recommended for daily tip feature)
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- OPTIONAL: Choose your preferred markdown renderer (or omit for raw markdown)
      "MeanderingProgrammer/render-markdown.nvim", -- Clean rendering
      -- OR: "OXY2DEV/markview.nvim", -- Rich rendering with advanced features
    },
    opts = {
      -- OPTIONAL: Location of user defined tips (default value shown below)
      user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
      -- OPTIONAL: Prefix for user tips to avoid conflicts (default: "[User] ")
      user_tip_prefix = "[User] ",
      -- OPTIONAL: Show warnings when user tips conflict with builtin (default: true)
      warn_on_conflicts = true,
      -- OPTIONAL: Daily tip mode (default: 1)
      -- 0 = off, 1 = once per day, 2 = every startup
      daily_tip = 1,
      -- OPTIONAL: Bookmark symbol (default: "🌟 ")
      bookmark_symbol = "🌟 ",
    },
    init = function()
      -- OPTIONAL: Change to your liking or drop completely
      -- The plugin does not provide default key mappings, only commands
      local map = vim.keymap.set
      map("n", "<leader>nto", ":NeovimTips<CR>", { desc = "Neovim tips", noremap = true, silent = true })
      map("n", "<leader>nte", ":NeovimTipsEdit<CR>", { desc = "Edit your Neovim tips", noremap = true, silent = true })
      map("n", "<leader>nta", ":NeovimTipsAdd<CR>", { desc = "Add your Neovim tip", noremap = true, silent = true })
      map("n", "<leader>nth", ":help neovim-tips<CR>", { desc = "Neovim tips help", noremap = true, silent = true })
      map("n", "<leader>ntr", ":NeovimTipsRandom<CR>", { desc = "Show random tip", noremap = true, silent = true })
      map("n", "<leader>ntp", ":NeovimTipsPdf<CR>", { desc = "Open Neovim tips PDF", noremap = true, silent = true })
    end
  }
}


