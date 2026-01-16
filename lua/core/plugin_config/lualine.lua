local job_indicator = { require("easy-dotnet.ui-modules.jobs").lualine }
require('lualine').setup {
  options = {
    icons_enabled = true,
  },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
      },
      { "mode", job_indicator }
    }
  }
}
