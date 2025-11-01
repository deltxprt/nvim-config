require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "rust", "vim", "go", "typescript", "javascript"},

  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
})
