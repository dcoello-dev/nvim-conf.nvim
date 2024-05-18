return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        dependencies = 'nvim-neotest/nvim-nio'
      },
      'ldelossa/nvim-dap-projects'
    },
    config= function()

      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { desc = 'DAP: ' .. desc })
      end
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      map( "<leader><F12>", function() dapui.toggle() end, "toggle dap")
      map( "<leader>db", function() dap.toggle_breakpoint() end, "toggle breakpoint")
      map( "<leader>dc", function() dap.continue() end, "continue") 
      map( "<leader>df", function() dap.terminate() end, "terminate")
      map( "<leader>di", function() dap.step_into() end, "into")
      map( "<leader>do", function() dap.step_out() end, "out") 
      map( "<leader>dn", function() dap.step_over() end, "over")

      dap.adapters.cpp = {
        type = 'executable',
        attach = {
          pidProperty = "pid",
          pidSelect = "ask"
        },
        command = 'lldb-vscode-10',
        env = {
          LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
        },
        name = "lldb"
      }

      dap.configurations.cpp = {
        {
          name = "lldb",
          type = "cpp",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}/../01_build/telemetry-consumer-app_gcc9-linux-x86_64/Debug',
          externalTerminal = false,
          stopOnEntry = false,
          args = {}
        },
      }

      local exec_dap = function(prompt_bufnr)
        local selected_entry = require("telescope.actions.state").get_selected_entry()
        local cpp_config = module.make_config() -- returns my basic config object with program set to a function that prompts vim.fn.input
        cpp_config.program = "../01_build/telemetry-consumer-app_gcc9-linux-x86_64/Debug" .. selected_entry[1]
        require("telescope.actions").close(prompt_bufnr)
        dap.run(cpp_config)
      end

      map('<leader>dx', function()
        dapui.toggle()
        require("telescope.builtin").find_files({
          attach_mappings = function(_, doit)
            doit("n", "<cr>", exec_dap)
            return true
          end,
        })
      end, "execute bin")
    end
  }
}
