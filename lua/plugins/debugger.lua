local function pick_binary()
  local dap = require('dap')
  -- Busca archivos ejecutables en el directorio actual (ignora .git y node_modules)
  local binarios = vim.fn.systemlist('find . -maxdepth 3 -executable -type f -not -path "*/.*"')
  
  vim.ui.select(binarios, {
    prompt = 'Selecciona el binario a debugear:',
    format_item = function(item) return "🚀 " .. item end,
  }, function(choice)
    if choice then
      dap.run({
        name = "bin",
        type = 'codelldb',
        request = 'launch',
        program = choice,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      })
    end
  end)
end

vim.keymap.set('n', '<leader>dd', pick_binary, { desc = 'DAP: Seleccionar y Lanzar' })

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
        -- Ver todos los valores locales en un flotante
        vim.keymap.set('n', '<leader>ds', function()
          local widgets = require('dap.ui.widgets')
          widgets.centered_float(widgets.scopes)
        end)

        dap.adapters.cpp = {
          type = 'executable',
          attach = {pidProperty = "pid", pidSelect = "ask"},
          command = 'lldb-vscode-14',
          env = {LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"},
          name = "lldb"
        }

        dap.configurations.cpp = {
          {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
          },
          {
            name = "Attach to process",
            type = 'codelldb',
            request = 'attach',
            pid = require('dap.utils').pick_process,
            args = {},
          },
        }

        require('dap-python').setup()
      end
    }
  }
}
