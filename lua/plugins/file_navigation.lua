return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
      require("oil").setup({default_file_explorer = true})
    end
  },
  {
    "mbbill/undotree",
    config = function ()
      vim.keymap.set('n', '<leader>pu', vim.cmd.UndotreeToggle)
    end
  },
}
