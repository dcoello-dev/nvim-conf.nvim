return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = {enabled = true, notify = true},
    explorer = {enabled = false},
    notifier = {enabled = true, timeout = 3000},
    quickfile = {enabled = true},
    statuscolumn = {enabled = true},
    picker = {
      enabled = true,
      sources = {
        files = { layout = { preset = "ivy" } },
        select = { layout = { preset = "dropdown" } },
      },
    },
    indent = {},
    zen = {
      enabled = true,
      toggles = {
        dim= true,
        git_signs = false,
        diagnostics = false,
        line_number = false,
        relative_number = false,
        signcolumn = "no",
        indent = false,
      },
    },
    styles = {
      notification = {
        wo = {wrap = true} -- Wrap notifications
      }
    }
  },
  keys = {
    { "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
    { "<leader>sf", function() Snacks.picker.files() end, desc = "[S]earch [F]iles" },
    { "<leader>ss", function() Snacks.picker.projects() end, desc = "[S]earch [S]elect Projects" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch current [W]ord" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "[S]earch [R]esume" },
    { "<leader>s.", function() Snacks.picker.recent() end, desc = '[S]earch Recent Files' },
    { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Find existing buffers" },
    {
      "<leader>/",
      function()
        Snacks.picker.lines({
          layout = { preset = "dropdown", preview = false },
        })
      end,
      desc = "[/] Fuzzily search in current buffer",
    },

    -- Grep en archivos abiertos
    {
      "<leader>s/",
      function()
        Snacks.picker.grep({ buffers = true })
      end,
      desc = "[S]earch [/] in Open Files",
    },

    -- Buscar en la configuración de Neovim
    {
      "<leader>sc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "[S]earch Neovim [C]onfig files",
    },

    -- Grep solo en el archivo actual (Tu antiguo <leader>f)
    {
      "<leader>f",
      function()
        Snacks.picker.grep({ filter = { paths = { vim.fn.expand("%:p") } } })
      end,
      desc = "Grep in current file",
    },

    -- Lógica personalizada de archivos asociados (Tu antiguo <leader>po)
    {
      "<leader>po",
      function()
        local text = require("ext.utils").GetAssociatedFiles()
        Snacks.picker.files({
          pattern = text,
          layout = { preset = "ivy" },
        })
      end,
      desc = "Jump to related files",
    },
    {
      "<leader>nh",
      function() Snacks.notifier.show_history() end,
      desc = "Notification History"
    },

    --- Git keymaps
    {"<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse"},
    {
      "<leader>gb",
      function() Snacks.git.blame_line() end,
      desc = "Git Blame Line"
    },
    {
      "<leader>gf",
      function() Snacks.lazygit.log_file() end,
      desc = "Lazygit Current File History"
    },
    {"<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit"},
    {
      "<leader>gh",
      function() Snacks.lazygit.log() end,
      desc = "Lazygit Log (cwd)"
    },
    {
      "<leader>un",
      function() Snacks.notifier.hide() end,
      desc = "Dismiss All Notifications"
    },
    {
      "<leader>gp",
      function() Snacks.picker.projects() end,
      desc = "[G]o to [P]rojects"
    },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3
          }
        })
      end
    },
    {
      "<leader>bz",
      function() Snacks.zen() end,
      desc = "zen mode"
    },
    {
      "<leader>ba",
      function() Snacks.bufdelete.all() end,
      desc = "Close [A]ll buffers"
    },
    {
      "<leader>bo",
      function() Snacks.bufdelete.other() end,
      desc = "delete [O]ther buffer"
    },
    {
      "<leader>bx",
      function() Snacks.bufdelete() end,
      desc = "delete buffer"
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.option("spell", {name = "Spelling"}):map("<leader>us")
        Snacks.toggle.option("wrap", {name = "Wrap"}):map("<leader>uw")
        Snacks.toggle.option("relativenumber", {name = "Relative Number"}):map(
          "<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", {
          off = 0,
          on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
        }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end
    })
  end
}
