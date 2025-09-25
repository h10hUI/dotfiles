--  _    __  ___  _     _    _ _____
--  | |  /_ |/ _ \| |   | |  | |_   _|
--  | |__ | | | | | |__ | |  | | | |
--  | '_ \| | | | | '_ \| |  | | | |
--  | | | | | |_| | | | | |__| |_| |_
--  |_| |_|_|\___/|_| |_|\____/|_____|

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ----------------------------------------
--  Load modules
-- ----------------------------------------
-- Basic settings
require('options').setup()

-- Helper functions & autocmds
local utils = require('utils')
utils.setup_autocmds()

-- User commands
require('commands').setup()

-- Autocmds (additional)
require('autocmds').setup()

-- Plugins
require('plugins.init').setup()

-- Treesitter (early initialization for folding)
require('plugins.treesitter').setup()

-- Key mappings
require('keymaps').setup()

-- Plugin specific settings
require('plugins.coc').setup()
require('plugins.fzf').setup()
require('plugins.misc').setup()
require('plugins.oil').setup()
require('plugins.gitsigns').setup()
require('plugins.hlchunk').setup()
require('plugins.lualine').setup()
require('plugins.copilotc').setup()
require('plugins.mini').setup()

-- Color settings
require('colors').setup()

-- Dvorak keybindings
require('dvorak').setup()

-- ----------------------------------------
--  Local .vimrc setting
-- ----------------------------------------
local dir = vim.fn.getcwd()
local vimrc_local = vim.fn.findfile(".vimrc.local", vim.fn.fnameescape(dir) .. ";")

if #vimrc_local > 1 then
  local rc = vim.fn.fnamemodify(vimrc_local, ":p:h") .. "/.vimrc.local"
  vim.cmd("source " .. rc)
end

-- vim: set ts=2 sw=2 et :
