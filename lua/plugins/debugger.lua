return {
  'ldelossa/nvim-dap-projects',
  'theHamsta/nvim-dap-virtual-text',
  'nvim-neotest/nvim-nio',
  'rcarriga/nvim-dap-ui',
  'mfussenegger/nvim-dap-python',
  {
    {
      'mfussenegger/nvim-dap',
      dependencies = {
        {'rcarriga/nvim-dap-ui', dependencies = 'nvim-neotest/nvim-nio'},
        {'theHamsta/nvim-dap-virtual-text'}
      },
      config = function()
        require("nvim-dap-virtual-text").setup()

        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, {desc = 'DAP: ' .. desc})
        end
        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()
        map("<leader>dx", function() dapui.toggle() end, "toggle dap")
        map("<leader>db", function() dap.toggle_breakpoint() end,
          "toggle breakpoint")
        map("<leader>dc", function() dap.continue() end, "continue")
        map("<leader>df", function() dap.terminate() end, "terminate")
        map("<leader>di", function() dap.step_into() end, "into")
        map("<leader>do", function() dap.step_out() end, "out")
        map("<leader>dn", function() dap.step_over() end, "over")

        dap.adapters.codelldb = {
          type = "server",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
          },
        }


        require('dap-python').setup("python3")
      end
    }
  }
}
