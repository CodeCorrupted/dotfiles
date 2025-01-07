local set = vim.opt

-- List of colorschemes
local colorschemes = { "duskfox", "nightfox", "nordfox", "terafox", "carbonfox", "dayfox", "dawnfox" }

-- Current index of the color scheme
local current_index = 1

-- Function to cycle through color schemes
function SwitchColorscheme()
	current_index = current_index + 1
	if current_index > #colorschemes then
		current_index = 1
	end
	local colorscheme = colorschemes[current_index]
	vim.cmd("colorscheme " .. colorscheme)
	vim.notify("Changed to colorscheme: " .. colorscheme, "info", { title = "Colorscheme Changed" })
end

vim.cmd("colorscheme " .. colorschemes[current_index])

-- Notify for any other plugin
vim.notify = require("notify")

set.expandtab = true
set.shiftwidth = 2
set.softtabstop = 2

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

set.timeoutlen = 500

vim.o.updatetime = 250

-- Diagnostics customization
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})

-- Autosave on Neovim
-- set.autowrite = true
