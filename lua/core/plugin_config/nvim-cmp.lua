-- import nvim-cmp plugin safely
local cmp = require("cmp")
local ctx = require("cmp.config.context")

vim.opt.completeopt = "menu,menuone,noselect"

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end

-- load VSCode-like snippets from plugins (e.g., friendly-snippets)


require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
  enabled = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    -- block comments only; allow strings/code
    if ctx.in_treesitter_capture("comment") or ctx.in_syntax_group("Comment") then
      return false
    end
    return true
  end,

  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then require("luasnip").expand_or_jump()
      else fallback() end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then require("luasnip").jump(-1)
      else fallback() end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources(
    {
      { name = "nvim_lsp",           keyword_length = 1 },  -- << was 3: blocked member completions
      { name = "nvim_lsp_signature_help" },
      { name = "luasnip" },
    },
    {
      { name = "path",  option = { trailing_slash = true } }, -- 'option', not 'options'
      { name = "buffer",              keyword_length = 2 },
    }
  ),

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = "λ",
        luasnip  = "⋗",
        buffer   = "Ω",
        path     = "🖫",
      }
      item.menu = menu_icon[entry.source.name] or item.menu
      return item
    end,
  },
})
