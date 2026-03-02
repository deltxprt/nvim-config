require('neo-tree').setup({
  -- options go here
  filesystem = {
    filtered_items = {
      visible = true,
      hide_hidden = false,
    }
  },
  window = {
    mappings = {
      ["P"] = {
        "toggle_preview",
        config = {
          use_float = false,
          -- use_image_nvim = true,
          -- use_snacks_image = true,
          -- title = 'Neo-tree Preview',
        },
      },
    }
  }
})


vim.keymap.set('n', '<c-n>', ':Neotree filesystem toggle float<CR>')
