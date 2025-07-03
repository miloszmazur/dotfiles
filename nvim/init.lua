local opt = vim.opt
vim.g.mapleader = " "

if vim.g.vscode then
  cmdheight = 1
  return
end

opt.clipboard = "unnamedplus"

opt.number = true
opt.relativenumber = true

opt.splitright = true
opt.splitbelow = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.cmdheight = 0

opt.cursorline = true

opt.wrap = false
opt.scrolloff = 8

opt.swapfile = false
opt.undofile = true
opt.hidden = true

opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.mouse = "a"

opt.signcolumn = "number"


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
require("lazy").setup("plugins")

require("remaps")

-- todo
-- status
-- formatters
-- that thing to highlight yank
