return {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        detection_methods = {  "pattern" },
        patterns = { "dev.sh"},
        datapath = vim.fn.stdpath("data"),
      }
    end
  }
