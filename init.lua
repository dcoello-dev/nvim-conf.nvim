vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = {tab = '» ', trail = '·', nbsp = '␣'}
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.o.autoread = true
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

local utils = require("ext.utils")
require("ext.autocommands")

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>pv', '<cmd>Oil<CR>', {desc = 'Project [V]isualization'})

vim.keymap.set('n', '<M-d>', vim.diagnostic.open_float, { desc = 'Show Error float' })
vim.keymap.set('n', '<M-j>', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<M-k>', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'Prev diagnostic' })
vim.keymap.set("n", "<M-n>", "<cmd>cnext<CR>zz", {desc = "Forward qfixlist"})
vim.keymap.set("n", "<M-p>", "<cmd>cprev<CR>zz", {desc = "Backward qfixlist"})
vim.keymap.set("n", "<M-o>", utils.toggle_quickfix, {desc = "toggle quickfix"})
vim.keymap.set('n', '<leader>qa', vim.diagnostic.setqflist, { desc = 'LSP Diagnostics to Quickfix' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc = 'Open diagnostic [Q]uickfix list'})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath
  }
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  {import = 'plugins'}
}


-- test_lsp.lua
local client_id = vim.lsp.start({
  name = 'docthor-lsp',
  cmd = {'docthor-lsp'},
  root_dir = vim.loop.cwd(), -- Intenta con vim.loop.cwd(),
})

if not client_id then
  print("No se pudo iniciar el LSP")
end

vim.api.nvim_create_user_command('Docthor', function()
    local clients = vim.lsp.get_active_clients({ name = 'docthor-lsp' })
    for _, client in ipairs(clients) do
        client.notify('workspace/executeAnalysis', {}) 
    end
end, {})

vim.diagnostic.config({
  virtual_text = true, -- Esto habilita el texto al final de la línea
  signs = true,        -- Iconos en la columna lateral (gutter)
  underline = true,    -- Subrayado debajo del código con error
})
