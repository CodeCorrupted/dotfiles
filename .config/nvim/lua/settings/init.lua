local set = vim.opt

-- Neovim's notifications will show with notify
vim.notify = require("notify")

-- Global function to change the colorscheme of Neovim.
-- Define a list of the colorscheme's names
local color_schemes = {
	"terafox",
	"nightfox",
	"duskfox",
	"nordfox",
	"carbonfox",
	"dayfox",
	"dawnfox",
}

-- Index for the actual colorscheme
local current_scheme = 1

-- Function to change to the next colorscheme
function ChangeColorScheme()
	current_scheme = current_scheme % #color_schemes + 1
	vim.cmd("colorscheme " .. color_schemes[current_scheme])

	local message = "Changing to: " .. color_schemes[current_scheme]
	vim.notify(message, "info", {
		title = "Colorscheme changed",
		timeout = 2000, -- Time in miliseconds
	})
end

-- Load the colorscheme at Neovim's start
vim.cmd("colorscheme " .. color_schemes[current_scheme])
-- vim.cmd("colorscheme terafox")

set.shiftwidth = 2
set.tabstop = 2

set.ignorecase = true
set.smartcase = true

set.splitbelow = true
set.splitright = true
set.wrap = false
set.fileencoding = "utf-8"
set.termguicolors = true

set.number = true
set.relativenumber = true
set.cursorline = true

set.foldcolumn = "1"
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"

set.termguicolors = true

set.timeoutlen = 500

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Autosave on Neovim
-- set.autowrite = true
