return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
      require("oil").setup({
        default_file_explorer = true,
        view_options = {
          show_hidden = true,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,

          is_always_hidden = function(name, bufnr)
            return false
          end,
        }
      })
    end
  },
  {
    "mbbill/undotree",
    config = function ()
      vim.keymap.set('n', '<leader>pu', vim.cmd.UndotreeToggle)
    end
  },
}
