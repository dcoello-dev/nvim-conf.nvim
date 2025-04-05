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
        {'rcarriga/nvim-dap-ui', dependencies = 'nvim-neotest/nvim-nio'}
      },
      config = function()

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

        dap.adapters.cpp = {
          type = 'executable',
          attach = {pidProperty = "pid", pidSelect = "ask"},
          command = 'lldb-vscode-14',
          env = {LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"},
          name = "lldb"
        }

        dap.configurations.cpp = {
          {
            name = "lldb",
            type = "cpp",
            request = "launch",
            program = os.getenv("DEXE"),
            cwd = '${workspaceFolder}/',
            externalTerminal = false,
            stopOnEntry = false,
            args = {}
          }
        }

        require('dap-python').setup()
      end
    }
  }
}
