local set = vim.opt

-- List of colorschemes
local colorschemes = { "nightfox", "dayfox", "dawnfox", "duskfox", "nordfox", "terafox", "carbonfox" }

-- Function to save the selected colorscheme on this file
local function save_colorscheme(scheme)
  local config_path = vim.fn.stdpath('config') .. '/lua/settings.lua'
  local content = ""
  local file = io.open(config_path, "r")

  if file then
    content = file:read("*a")
    file:close()
  end

  -- Search for and replace the colorscheme line
  local new_content, count = content:gsub(
    'vim%.cmd%("colorscheme%s+%w+"%)',
    'vim.cmd("colorscheme ' .. scheme .. '")'
  )
  -- In case that the previous line doesn't exist
  if count == 0 then
    new_content = content .. '\n' .. 'vim.cmd("colorscheme ' .. scheme .. '")'
  end

  -- Write the new content
  local file = io.open(config_path, "w")
  if file then
    file:write(new_content)
    file:close()
  end
end

-- Apply the colorscheme at start
vim.cmd("colorscheme carbonfox")

-- Function to cycle through color schemes
function SwitchColorscheme()
  local current_colorscheme = vim.g.colors_name or "nightfox"
  local next_index = 1

  -- Find the current index
  for i, scheme in ipairs(colorschemes) do
    if scheme == current_colorscheme then
      next_index = i % #colorschemes + 1
      break
    end
  end

  local next_scheme = colorschemes[next_index]
  vim.cmd("colorscheme " .. next_scheme)
  save_colorscheme(next_scheme)
  vim.notify("Changed to colorscheme: " .. next_scheme, 2, { title = "Colorscheme Changed" })
end

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
