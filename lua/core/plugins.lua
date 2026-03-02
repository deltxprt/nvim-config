return {
  -- themes

  {
    "rebelot/kanagawa.nvim",
    config = function ()
      require("core.plugin_config.colorscheme")
    end,
  },

  -- UI Helper
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
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    --version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    config = function()
      require('core.plugin_config.blink')
    end,
    opts_extend = { "sources.default" }
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

  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        nextls = {enable = true},
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
        projectionist = {
          enable = true
        }
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- DAP

  {
   "mfussenegger/nvim-dap",
   event = "VeryLazy",
   config = function ()
     require("core.plugin_config.dap")
   end
  },

  -- Dotnet
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
    config = function()
      require("easy-dotnet").setup()
    end
  },

  -- F#
  {
    -- F# support
    'ionide/Ionide-vim',
    ft = { 'fsharp', 'fsharp_project' },
    config = function()
      -- if you need extra configuration/events, example with 'Show tooltips on CursorHold'
      -- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      --   pattern = { '*.fs', '*.fsi', '*.fsx' },
      --   callback = function()
      --     vim.fn['fsharp#showTooltip']()
      --   end,
      -- })

      -- Show fsi in horizontal split
      -- vim.g["fsharp#fsi_window_command"] = "vnew"
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
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      -- { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { expr = true, desc = "Add range to opencode" })
      vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" })

      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })

      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
    end,
  }
}


