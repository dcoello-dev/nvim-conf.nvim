return {
  {
    'dcoello-dev/monokai-old.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Load the colorscheme here
      vim.cmd.colorscheme 'monokai'
      vim.cmd.hi 'Comment gui=none'
      vim.api.nvim_set_hl(0, 'LineNr', {fg = '#ff4e00', bold = true})
      vim.api.nvim_set_hl(0, 'CursorLineNr', {fg = '#80FF33', bold = true})
      vim.api.nvim_set_hl(0, 'Blamer', {fg = '#ff4e00', bold = true})
      vim.api.nvim_set_hl(0, 'Visual',
        {fg = "#eb03fc", bg = "#35fc03", bold = true})
      vim.cmd('highlight Normal guibg=none')
      vim.g.blamer_enabled = true
      vim.g.blamer_delay = 500
    end
  },
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = {name = '[C]ode', _ = 'which_key_ignore'},
        ['<leader>d'] = {name = '[D]ocument', _ = 'which_key_ignore'},
        ['<leader>r'] = {name = '[R]ename', _ = 'which_key_ignore'},
        ['<leader>s'] = {name = '[S]earch', _ = 'which_key_ignore'},
        ['<leader>w'] = {name = '[W]orkspace', _ = 'which_key_ignore'}
      }
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          component_separators = '|',
          section_separators = ''
        },
        sections = {
          lualine_x = {
            {
              color = {fg = "#ff9e64"}
            },
            {
              color = {fg = "#ff9e64"}
            }
          }
        }
      }
    end
  }
}
