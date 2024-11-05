-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers default
vim.opt.number = true
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

function loki_build(opts)
vim.opt.makeprg = 'bash dev.sh -b'
  vim.cmd.make()
end

function loki_test(opts)
vim.opt.makeprg = 'bash dev.sh -t'
  vim.cmd.make()
end

vim.api.nvim_create_user_command(
  "Build",
  function(opts)
    loki_build(opts.args)
  end,
  { nargs = '?' }
)

vim.api.nvim_create_user_command(
  "Test",
  function(opts)
    loki_test(opts.args)
  end,
  { nargs = '?' }
)
-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>pb', '<cmd>NvimTreeToggle<CR>', { desc = 'Project [B]isualization' })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Project [V]isualization' })
vim.keymap.set('n', '<leader>pc', '<cmd>NvimTreeCollapse<CR>', { desc = 'Project [V]isualization' })
vim.keymap.set('n', '<leader>ba', '<cmd>%bdelete|edit #|normal`"<CR>', { desc = 'Close [A]ll buffers except current'})
vim.keymap.set('n', '<leader>bx', '<cmd>bd<CR>', { desc = 'Close [X] current buffer'})

function SplitPath(strFilename)
  -- Returns the Path, Filename, and Extension as 3 values
   return string.match(strFilename, "(.-)([^\\/]-([^\\/%.]+))$")
end

function GetAssociatedFiles()
    local file_path = vim.fn.expand("%")
    local path, file, extension = SplitPath(file_path)
    file = file:gsub("\n", "")
    file = file:gsub("Mock", "")
    file = file:gsub("Test", "")
    file = file:gsub(".h", "")
    file = file:gsub(".cpp", "")
    if #file > 0 then
        return file
    else
        return ''
    end
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'APZelos/blamer.nvim', -- Git blame
  'mg979/vim-visual-multi', -- multicursor
  'nvim-lualine/lualine.nvim', -- Fancier statusline
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  "tpope/vim-surround",
  "rlane/pounce.nvim",
  -- Tree
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   version = "*",
  --   lazy = false,
  --   requires = {
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   config = function()
  --     require("nvim-tree").setup {
  --       update_focused_file = {
  --         enable = true,
  --       }
  --     }
  --   end,
  -- },
--   {
--     "tris203/precognition.nvim",
--     --event = "VeryLazy",
--     opts = {
--     -- startVisible = true,
--     -- showBlankVirtLine = true,
--     highlightColor = { link = "IncSearch" },
--     -- hints = {
--     --      Caret = { text = "^", prio = 2 },
--     --      Dollar = { text = "$", prio = 1 },
--     --      MatchingPair = { text = "%", prio = 5 },
--     --      Zero = { text = "0", prio = 1 },
--     --      w = { text = "w", prio = 10 },
--     --      b = { text = "b", prio = 9 },
--     --      e = { text = "e", prio = 8 },
--     --      W = { text = "W", prio = 7 },
--     --      B = { text = "B", prio = 6 },
--     --      E = { text = "E", prio = 5 },
--     -- },
--     -- gutterHints = {
--     --     G = { text = "G", prio = 10 },
--     --     gg = { text = "gg", prio = 9 },
--     --     PrevParagraph = { text = "{", prio = 8 },
--     --     NextParagraph = { text = "}", prio = 8 },
--     -- },
--     -- disabled_fts = {
--     --     "startify",
--     -- },
--     },
-- },
  {
    'aspeddro/slides.nvim',
    config = function ()
      require'slides'.setup{}
    end
  },
  {
    'dcoello-dev/sandbox.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'akinsho/toggleterm.nvim',
      'ellisonleao/glow.nvim',
    },
    config= function()
      require("sandbox").setup({
        work_idea_path="/home/dcoello/doc/codebase/ideas/",
        ideas_path="/home/dcoello/doc/codebase/ideas/",
      })
    end
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope.nvim"},
    },
    event = "LspAttach",
    config = function()
      require('tiny-code-action').setup()
    end
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  -- {
  --   "rcarriga/nvim-notify",
  --   config = function()
  --     require("notify").setup({
  --       background_colour = "#000000",
  --       enabled = false,
  --     })
  --   end
  -- },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
        routes = {
          {
            filter = {
              event = 'msg_show',
              any = {
                { find = '%d+L, %d+B' },
                { find = '; after #%d+' },
                { find = '; before #%d+' },
                { find = '%d fewer lines' },
                { find = '%d more lines' },
              },
            },
            opts = { skip = true },
          }
        },
      })
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
    }
  },
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
    end,
  },
  {
    -- amongst your other plugins
    -- {'akinsho/toggleterm.nvim', version = "*", config = true}
    -- or
    {
      'akinsho/toggleterm.nvim', version = "*", opts = {
        --[[ things you want to change go here]]
        open_mapping = [[<c-a>]],  
        hide_numbers = false,
        direction = 'tab',
      }
    }
  },
  {
  "ribelo/taskwarrior.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    -- or 
    config = true
},
  {
    "mbbill/undotree"
  },
  {
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
        map( "<leader>dx", function() dapui.toggle() end, "toggle dap")
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
  },
  { import = 'custom.plugins' },
}

vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#ff4e00', bold = true })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#80FF33', bold = true })
vim.api.nvim_set_hl(0, 'Blamer', { fg = '#ff4e00', bold = true })
vim.api.nvim_set_hl(0, 'Visual', {fg= "#eb03fc", bg = "#35fc03", bold=true} )
vim.g.blamer_enabled = true
vim.g.blamer_delay = 500

require('lualine').setup {
  options = {
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_x = {
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      },
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
        color = { fg = "#ff9e64" },
      },
    },
    lualine_a = {
      {
        'buffers',
      }
    }
  }
}


local cmp_nvim_lsp = require "cmp_nvim_lsp"

require("lspconfig").clangd.setup {
  on_attach = on_attach,
  capabilities = cmp_nvim_lsp.default_capabilities(),
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}

vim.keymap.set("n", "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>tl", function()
  require("taskwarrior_nvim").browser({"ready"})
end, { noremap = true, silent = true })

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
--
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

if not configs.lspdc_lsp then
  configs.lspdc_lsp = {
    default_config = {
      cmd = { 'python3', '/home/dcoello/code/lsp-dc/main.py' },
      root_dir = lspconfig.util.root_pattern('.git'),
      filetypes = { 'python' },
    },
  }
end
lspconfig.lspdc_lsp.setup {}

vim.keymap.set("n", "f", function()
  require("pounce").pounce { }
end, { noremap = true, silent = true })
