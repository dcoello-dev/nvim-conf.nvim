local M = {
  "nvim-neorg/neorg",
  ft = "norg",
  dependencies = {
    "luarocks.nvim", -- this is it.
    -- "nvim-treesitter/nvim-treesitter",
    -- "nvim-treesitter/nvim-treesitter-textobjects",
    -- "nvim-cmp",
    -- "nvim-lua/plenary.nvim",
  },
  -- build = ":Neorg sync-parsers", -- and delete this line.
  cmd = "Neorg",
}

local modules = {
  ["core.defaults"] = {},
  ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
  ["core.integrations.nvim-cmp"] = {},
  ["core.summary"] = {},
  ["core.concealer"] = {
    config = {
      icon_preset = "diamond",
      -- icons = {
      --   todo = {
      --     urgent = {
      --       icon = ":tiger2:",
      --     },
      --   }
      -- }
    },
  },
  ["core.keybinds"] = {
    config = {
      default_keybinds = true,
    },
  },
  ["core.dirman"] = {
    config = {
      workspaces = {
        notes = "~/doc/codebase/ideas/notes",
      },
      default_workspace = "notes",
    }
  },
}

M.opts = {
  load = modules,
}

return M
