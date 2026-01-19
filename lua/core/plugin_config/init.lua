------------------------------------------------------------
-- 1️⃣  Global basics – leader key, options, keymaps, etc.
------------------------------------------------------------
vim.g.mapleader = " "                     -- set leader early

-- If you have separate option/keymap modules, load them here
-- (they do NOT depend on any plugins, so they stay eager)
require("core.options")   -- <-- create this if you have one
require("core.keymaps")   -- <-- create this if you have one


------------------------------------------------------------
-- 2️⃣  Bootstrap Lazy (install if missing)
------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",               -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


------------------------------------------------------------
-- 3️⃣  Load the plugin list (Lazy will take care of the rest)
------------------------------------------------------------
-- The string `"core.plugins"` tells Lazy to `require("core.plugins")`,
-- which must return a table of plugin specifications (see the next section).
require("lazy").setup("core.plugins", {
  -- OPTIONAL: tweak Lazy’s UI / behaviour here
  ui = {
    border = "rounded",
    icons = {
      ft = "",
      lazy = "󰂠",
      loaded = "",
      not_loaded = "",
    },
  },

  -- Example: disable a few built‑in Vim plugins you never use
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

  -- Change‑detection – automatically re‑source a plugin file when you edit it
  change_detection = {
    enabled = true,
    notify = false,
  },
})
