return {
  'tpope/vim-sleuth',
  'APZelos/blamer.nvim',
  'mg979/vim-visual-multi',
  "sindrets/diffview.nvim",
  {'grzegorzszczepanek/gamify.nvim', config = function() require('gamify') end},
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  }
}
