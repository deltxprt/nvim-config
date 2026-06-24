-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--
-- This file contains installation and configuration of plugins outside of MINI.
-- They significantly improve user experience in a way not yet possible with MINI.
-- These are mostly plugins that provide programming language specific behavior.
--
-- Use this file to install and configure other such plugins.

-- Make concise helpers for installing/adding plugins in two stages
local add = vim.pack.add
local now_if_args, later, now = Config.now_if_args, Config.later, Config.now
local version = vim.version.range
local gh = function(x) return 'https://github.com/' .. x end

-- Tree-sitter ================================================================

-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
--   NOTE: It requires third party software to build and install parsers.
--   See the link for more info in "Requirements" section of the MiniMax README.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.treesitter nvim-treesitter` to see potential issues.
-- - In case of errors related to queries for Neovim bundled parsers (like `lua`,
--   `vimdoc`, `markdown`, etc.), manually install them via 'nvim-treesitter'
--   with `:TSInstall <language>`. Be sure to have necessary system dependencies
--   (see MiniMax README section for software requirements).
now_if_args(function()
  add({gh('arborist-ts/arborist.nvim')})

  require("arborist").setup({
    update_cadence = "weekly",
    overrides = {
      norg = { url = gh("nvim-neorg/tree-sitter-norg") },
      norg_meta = { url = gh("nvim-neorg/tree-sitter-norg-meta") }
    }
  })
end)
--now_if_args(function()
--  -- Define hook to update tree-sitter parsers after plugin is updated
--  local ts_update = function() vim.cmd('TSUpdate') end
--  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')
--
--  add({
--    gh('nvim-treesitter/nvim-treesitter'),
--    gh('nvim-treesitter/nvim-treesitter-textobjects'),
--  })
--
--  -- Define languages which will have parsers installed and auto enabled
--  -- After changing this, restart Neovim once to install necessary parsers. Wait
--  -- for the installation to finish before opening a file for added language(s).
--  local languages = {
--    -- These are already pre-installed with Neovim. Used as an example.
--    'lua',
--    'vimdoc',
--    'markdown',
--    -- Add here more languages with which you want to use tree-sitter
--    -- To see available languages:
--    -- - Execute `:=require('nvim-treesitter').get_available()`
--    -- - Visit 'SUPPORTED_LANGUAGES.md' file at
--    --   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
--  }
--  local isnt_installed = function(lang)
--    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
--  end
--  local to_install = vim.tbl_filter(isnt_installed, languages)
--  if #to_install > 0 then require('nvim-treesitter').install(to_install) end
--
--  -- Enable tree-sitter after opening a file for a target language
--  local filetypes = {}
--  for _, lang in ipairs(languages) do
--    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
--      table.insert(filetypes, ft)
--    end
--  end
--  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
--  Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
--end)

now_if_args(function()
  add({
    gh('nvim-lua/plenary.nvim'),
    gh('nvim-telescope/telescope.nvim'),
    gh('MunifTanjim/nui.nvim'),
    gh('MeanderingProgrammer/render-markdown.nvim')
  })
end)

-- Language servers ===========================================================

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
-- See note about 'mason.nvim' at the bottom of the file.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.
now_if_args(function()
  add({ gh('neovim/nvim-lspconfig') })

  -- Use `:h vim.lsp.enable()` to automatically enable language server based on
  -- the rules provided by 'nvim-lspconfig'.
  -- Use `:h vim.lsp.config()` or 'after/lsp/' directory to configure servers.
  -- Uncomment and tweak the following `vim.lsp.enable()` call to enable servers.
  -- vim.lsp.enable({
  --   -- For example, if `lua-language-server` is installed, use `'lua_ls'` entry
  -- })
end)

-- DAP plugins

now_if_args(function()
  add({
    gh('mfussenegger/nvim-dap'),
    gh('theHamsta/nvim-dap-virtual-text')
  })

  require("nvim-dap-virtual-text").setup()
  local dap = require("dap")

  local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = mason_path,
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.go = {
    {
      type = "codelldb",
      request = "launch",
      name = "Debug",
      program = "${file}"
    },
  }
end)

now_if_args(function()
  add({
    gh('ray-x/go.nvim')
  })

  require('go').setup()
end)

-- Formatting =================================================================

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
later(function()
  add({ gh('stevearc/conform.nvim') })

  -- See also:
  -- - `:h Conform`
  -- - `:h conform-options`
  -- - `:h conform-formatters`
  require('conform').setup({
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = 'fallback',
    },
    -- Map of filetype to formatters
    -- Make sure that necessary CLI tool is available
    -- formatters_by_ft = { lua = { 'stylua' } },
  })
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function()
  add({gh('rafamadriz/friendly-snippets')})
end)

-- Honorable mentions =========================================================

now_if_args(function()
  add({ gh('GustavEikaas/easy-dotnet.nvim') })
  require('easy-dotnet').setup()
  vim.lsp.enable({'easy-dotnet'})
end)
-- 'mason-org/mason.nvim' (a.k.a. "Mason") is a great tool (package manager) for
-- installing external language servers, formatters, and linters. It provides
-- a unified interface for installing, updating, and deleting such programs.
--
-- The caveat is that these programs will be set up to be mostly used inside Neovim.
-- If you need them to work elsewhere, consider using other package managers.
--
-- You can use it like so:
now_if_args(function()
  add({
    gh('saghen/blink.cmp'),
  })

  local function build_blink(params)
    vim.notify('Building blink.cmp', vim.log.levels.INFO)
    local obj = vim.system({ 'cargo', 'build', '--release' }, { cwd = params.path }):wait()
    if obj.code == 0 then
      vim.notify('Building blink.cmp done', vim.log.levels.INFO)
    else
      vim.notify('Building blink.cmp failed', vim.log.levels.ERROR)
    end
  end
  Config.on_packchanged('blink.cmp', { 'update' }, build_blink, ':BuildBlink')
  require('blink.cmp').setup({
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = true } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    -- 'easy-dotnet'
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'easy-dotnet' },
      providers = {
        ["easy-dotnet"] = {
          name = "easy-dotnet",
          enabled = true,
          module = "easy-dotnet.completion.blink",
          score_offset = 10000,
          async = true,
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },

    signature = { enabled = true },

  })

end)

now_if_args(function()
  add(
    {
      gh('mason-org/mason.nvim'),
      gh('mason-org/mason-lspconfig.nvim'),
    }
  )
  require('mason').setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "gopls", "lua_ls", "bashls" },
    automatic_installation  = true
  })
end)


-- Beautiful, usable, well maintained color schemes outside of 'mini.nvim' and
-- have full support of its highlight groups. Use if you don't like 'miniwinter'
-- enabled in 'plugin/30_mini.lua' or other suggested 'mini.hues' based ones.
Config.now(function()
  add({
    gh('rebelot/kanagawa.nvim')
  })
  vim.cmd('color kanagawa')
end)

later(function()
  add({gh('kdheepak/lazygit.nvim')})
end)

Config.now(function()
  add({
    {src=gh('nvim-neorg/lua-utils.nvim')},
    {src=gh("pysan3/pathlib.nvim")},
    {src=gh('nvim-neotest/nvim-nio')},
    {src=gh("nvim-neorg/neorg")},
    {src=gh("nvim-neorg/tree-sitter-norg")},
    {src=gh("nvim-neorg/tree-sitter-norg-meta")}
  })
  require('neorg').setup({
    load = {
      ['core.defaults'] = {},
      ['core.summary'] = {},
      ['core.concealer']  = {},
      ['core.dirman'] = {
        config = {
          workspaces = {
            main = '~/notes',
          },
          index = 'index.norg',
          default_workspace = 'main',
        }
      }
    }
  })
end)
--later(function()
--  add({
--    src = gh('saxon1964/neovim-tips'),
--    version = version('*')
--  })
--end)
