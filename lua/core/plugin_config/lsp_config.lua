require("mason").setup()

require("mason-lspconfig").setup({
  -- tweak this list␍
  ensure_installed = { "lua_ls", "ts_ls", "gopls" },
  automatic_enable = true, -- uses :h vim.lsp.enable() under the hood␍
})

-- Per-server settings go through the new native API.␍
-- Define BEFORE automatic_enable runs.␍
vim.lsp.config("lua_ls", {
  settings = {
    Lua = { diagnostics = { globals = { "vim" } } },
  },
})

-- Global on_attach: your mappings + inlay hints␍
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    end
    local map = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf })
    end
    map('n', 'rn', vim.lsp.buf.rename)
    map('n', 'ca', vim.lsp.buf.code_action)
    map('n', 'gd', vim.lsp.buf.definition)
    map('n', 'gi', vim.lsp.buf.implementation)
    map('n', 'gr', require('telescope.builtin').lsp_references)
    map('n', 'K',  vim.lsp.buf.hover)
  end,
})

--[[
--require("mason").setup()
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ts_ls", "gopls", ""}
})
require("mason-lspconfig").setup_handlers{
  function (server_name)
    lspconfig[server_name].setup {
      inlay_hints = {
        enabled = true,
      }
    }
  end,
}
local on_attach = function(_, bufnr)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end
--]]
