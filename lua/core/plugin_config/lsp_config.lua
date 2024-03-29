require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "gopls", "tsserver", "jsonls", "html", "cssls", "yamlls", "bashls", "dockerls", "tailwindcss", "ansiblels" },
})

local on_attach = function(_, bufnr)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end


require("lspconfig").lua_ls.setup {
  on_attach = on_attach,
}

require("lspconfig").gopls.setup {
  on_attach = on_attach,
}

require("lspconfig").tsserver.setup {
  on_attach = on_attach,
}

require("lspconfig").jsonls.setup {
  on_attach = on_attach,
}

require("lspconfig").html.setup {
  on_attach = on_attach,
}

require("lspconfig").cssls.setup {
  on_attach = on_attach,
}

require("lspconfig").yamlls.setup {
  on_attach = on_attach,
}

require("lspconfig").bashls.setup {
  on_attach = on_attach,
}

require("lspconfig").dockerls.setup {
  on_attach = on_attach,
}

require("lspconfig").tailwindcss.setup {
  on_attach = on_attach,
}

require("lspconfig").ansiblels.setup {
  on_attach = on_attach,
}
