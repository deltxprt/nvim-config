--require("mason").setup()
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup()
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

