return {
  'saghen/blink.cmp',
  dependencies = { 
    'rafamadriz/friendly-snippets',
    'moyiz/blink-emoji.nvim'
  },
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    -- tab on snippet to go to next field
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = true } },
    signature = {enabled = true},
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', "emoji" },
      providers = {
        emoji = {
          module = "blink-emoji",
          name = "Emoji",
          score_offset = 15, -- Tune by preference
          opts = { insert = true }, -- Insert emoji (default) or complete its name
          should_show_items = function()
            return vim.tbl_contains(
              { "gitcommit", "markdown" },
              vim.o.filetype
            )
          end,
        }
      }
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
