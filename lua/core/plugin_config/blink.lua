require("blink.cmp").setup {

  keymap = { preset = 'default' },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },

  signature = { enabled = true },

  fuzzy = {
    implementation = "prefer_rust_with_warning"
  },
  sources = {
    default = { "lsp", "easy-dotnet", "path" },
    providers = {
      ["easy-dotnet"] = {
        name = "easy-dotnet",
        enabled = true,
        module = "easy-dotnet.completions.blink",
        score_offset = 10000,
        async = true,
      },
    },
  },
}
