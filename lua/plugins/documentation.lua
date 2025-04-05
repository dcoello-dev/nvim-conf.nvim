return {
  {'mracos/mermaid.vim'},
  {"ellisonleao/glow.nvim", config = true, cmd = "Glow"},
  {
    "3rd/image.nvim",
    dependencies = {},
    opts = {},
    config = function()
      require('image').setup({
        integrations = {
          markdown = {
            resolve_image_path = function(document_path, image_path, fallback)
              return fallback(document_path, image_path)
            end
          }
        }
      })
    end
  },
  {
    'dcoello-dev/sandbox.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'akinsho/toggleterm.nvim',
      'ellisonleao/glow.nvim'
    },
    config = function()
      require("sandbox").setup({
        work_idea_path = "/home/dcoello/doc/codebase/ideas/",
        ideas_path = "/home/dcoello/doc/codebase/ideas/",
        conf_path = "/home/dcoello/doc/codebase/environments.toml"
      })
    end
  },
  {
    "3rd/diagram.nvim",
    dependencies = {"3rd/image.nvim"},
    opts = { -- you can just pass {}, defaults below
      renderer_options = {
        mermaid = {
          background = nil, -- nil | "transparent" | "white" | "#hex"
          theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
          scale = 1, -- nil | 1 (default) | 2  | 3 | ...
          width = nil, -- nil | 800 | 400 | ...
          height = nil -- nil | 600 | 300 | ...
        },
        plantuml = {charset = nil},
        d2 = {
          theme_id = nil,
          dark_theme_id = nil,
          scale = nil,
          layout = nil,
          sketch = nil
        },
        gnuplot = {
          size = nil, -- nil | "800,600" | ...
          font = nil, -- nil | "Arial,12" | ...
          theme = nil -- nil | "light" | "dark" | custom theme string
        }
      }
    },
    config = function()
      require("diagram").setup({
        integrations = {
          require("diagram.integrations.markdown"),
          require("diagram.integrations.neorg")
        },
        renderer_options = {
          mermaid = {theme = "forest"},
          plantuml = {charset = "utf-8"},
          d2 = {theme_id = 1},
          gnuplot = {theme = "dark", size = "800,600"}
        }
      })
    end
  },
  {'aspeddro/slides.nvim', config = function() require'slides'.setup {} end},
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim'}, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {}
  }
}
