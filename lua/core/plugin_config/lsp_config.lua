require("mason").setup()
local capabilities = require("blink.cmp").get_lsp_capabilities()
require("mason-lspconfig").setup({
  ensure_installed = { "gopls", "lua_ls", "bashls" },
  automatic_installation = true
})


-- Start gopls per Go buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function(args)
    local bufnr = args.buf
    -- avoid duplicate clients
    if next(vim.lsp.get_clients({ name = "gopls", bufnr = bufnr })) then return end

    vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      capabilities = capabilities,
      root_dir = vim.fs.dirname(
        vim.fs.find({ "go.work", "go.mod", ".git" }, { path = vim.api.nvim_buf_get_name(bufnr), upward = true })[1]
      ),
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
        },
      },
    })
  end,
})

-- Lua LS (silence 'vim' global warning)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function(args)
    local bufnr = args.buf
    if next(vim.lsp.get_clients({ name = "lua_ls", bufnr = bufnr })) then return end
    vim.lsp.start({
      name = "lua_ls",
      cmd = { "lua-language-server" },
      capabilities = capabilities,
      root_dir = vim.fs.dirname(
        vim.fs.find({ ".luarc.json", ".luarc.jsonc", ".git" }, { path = vim.api.nvim_buf_get_name(bufnr), upward = true })[1]
      ),
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
        },
      },
    })
  end,
})
