return {
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        keymaps = {
          ["<C-h>"] = { callback = function() vim.cmd("TmuxNavigateLeft") end },
          ["<C-j>"] = { callback = function() vim.cmd("TmuxNavigateDown") end },
          ["<C-k>"] = { callback = function() vim.cmd("TmuxNavigateUp") end },
          ["<C-l>"] = { callback = function() vim.cmd("TmuxNavigateRight") end },
          ["<C-p>"] = "actions.preview",
        },
        view_options = {
          show_hidden = true,
          is_hidden_file = function(name)
            return vim.startswith(name, ".")
          end,
          is_always_hidden = function()
            return false
          end,
        },
        float = {
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = "rounded",
        },
      })
    end
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set('n', '<leader>pu', vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
    end
  },
}
