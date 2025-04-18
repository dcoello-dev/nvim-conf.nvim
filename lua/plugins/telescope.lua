return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "benfowler/telescope-luasnip.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable 'make' == 1 end
      },
      {'nvim-telescope/telescope-ui-select.nvim'}

    },
    config = function()
      require('telescope').setup {
        pickers = {find_files = {theme = "ivy"}},
        extensions = {
          ['ui-select'] = {require('telescope.themes').get_dropdown()},
          fzf = {}
        }
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension('luasnip'))

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags,
        {desc = '[S]earch [H]elp'})
      vim.keymap.set('n', '<leader>sk', builtin.keymaps,
        {desc = '[S]earch [K]eymaps'})
      vim.keymap.set('n', '<leader>sf', builtin.find_files,
        {desc = '[S]earch [F]iles'})
      vim.keymap.set('n', '<leader>ss', builtin.builtin,
        {desc = '[S]earch [S]elect Telescope'})
      vim.keymap.set('n', '<leader>sw', builtin.grep_string,
        {desc = '[S]earch current [W]ord'})
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics,
        {desc = '[S]earch [D]iagnostics'})
      vim.keymap.set('n', '<leader>sr', builtin.resume,
        {desc = '[S]earch [R]esume'})
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles,
        {desc = '[S]earch Recent Files ("." for repeat)'})
      vim.keymap.set('n', '<leader><leader>', builtin.buffers,
        {desc = '[ ] Find existing buffers'})
      vim.keymap.set('n', '<leader>f', function()
        require("telescope.builtin").live_grep({
          search_dirs = {vim.fn.expand("%:p")}
        })
      end, {desc = '[ ] Find existing buffers'})

      vim.keymap.set('n', '<leader>po', function()
        local text = require("ext.utils").GetAssociatedFiles()
        builtin.find_files({
          default_text = text,
          theme = require('telescope.themes').get_ivy({})
        })
      end, {
        desc = '[O] jGo to previous [D]iagnostic messageump to related files'
      })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(
          require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false
          })
      end, {desc = '[/] Fuzzily search in current buffer'})

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files'
        }
      end, {desc = '[S]earch [/] in Open Files'})

      vim.keymap.set('n', '<leader>sc', function()
        builtin.find_files {cwd = vim.fn.stdpath 'config'}
      end, {desc = '[S]earch Neovim [C]onfig files'})

      vim.keymap.set('n', '<leader>sp', function()
        require'telescope'.extensions.projects.projects {}
      end, {desc = '[S]earch [P]rojects'})

      require"ext.ext".setup()
    end
  }
}

