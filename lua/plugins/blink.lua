return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'moyiz/blink-emoji.nvim'
  },
  version = '1.*',

  opts = {
    keymap = {
      preset = 'none',
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<Tab>'] = { 'accept', 'fallback' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
    },
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
          score_offset = 15,
          opts = { insert = true },
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
