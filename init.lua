vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.expandtab = true
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

local utils = require("ext.utils")
require("ext.autocommands")

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>pv', '<cmd>Oil<CR>',
  {desc = 'Project [V]isualization'})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
  {desc = 'Go to previous [D]iagnostic message'})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
  {desc = 'Go to next [D]iagnostic message'})
vim.keymap.set("n", "<M-n>", "<cmd>cnext<CR>zz", {desc = "Forward qfixlist"})
vim.keymap.set("n", "<M-p>", "<cmd>cprev<CR>zz", {desc = "Backward qfixlist"})
vim.keymap.set("n", "<M-o>", utils.toggle_quickfix, {desc = "toggle quickfix"})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
  {desc = 'Show diagnostic [E]rror messages'})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
  {desc = 'Open diagnostic [Q]uickfix list'})

vim.keymap.set('n', '<C-h>', '<C-w><C-h>',
  {desc = 'Move focus to the left window'})
vim.keymap.set('n', '<C-l>', '<C-w><C-l>',
  {desc = 'Move focus to the right window'})
vim.keymap.set('n', '<C-j>', '<C-w><C-j>',
  {desc = 'Move focus to the lower window'})
vim.keymap.set('n', '<C-k>', '<C-w><C-k>',
  {desc = 'Move focus to the upper window'})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath
  }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  {"vhyrro/luarocks.nvim", priority = 1000, config = true}, -- LuaFormatter off
    'tpope/vim-sleuth',
    'APZelos/blamer.nvim',
    'mg979/vim-visual-multi',
    -- LuaFormatter on
  {'grzegorzszczepanek/gamify.nvim', config = function() require('gamify') end},
  {import = 'plugins'}
}
