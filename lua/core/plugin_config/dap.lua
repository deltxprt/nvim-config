require("nvim-dap-virtual-text").setup()
local dap = require("dap")

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = mason_path,
    args = { "--port", "${port}" },
  },
}

dap.configurations.go = {
  {
    type = "codelldb",
    request = "launch",
    name = "Debug",
    program = "${file}"
  },
}
