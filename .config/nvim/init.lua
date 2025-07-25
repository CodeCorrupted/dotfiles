-- Bootstrap for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- Set Space as mapleader
-- This is the recommended way to do it
vim.g.mapleader = " "

-- Plugins
require("lazy").setup(require("plugins"))

-- Basic settings for Neovim
require("settings")

-- Mappings
require("mappings")
