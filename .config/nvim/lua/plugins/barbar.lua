-- Function to modify the colorscheme of barbar
local function setup_barbar_highlights()
  local nightfox = require("nightfox.palette")
  local palette = nightfox.load(vim.g.colors_name) -- Get the current colorscheme's palette

  vim.api.nvim_set_hl(0, "BufferCurrent", {
    fg = palette.fg1,
    bg = palette.bg3,
    bold = true
  })
  vim.api.nvim_set_hl(0, "BufferCurrentIndex", {
    fg = palette.cyan.bright,
    bg = palette.bg3
  })
  vim.api.nvim_set_hl(0, "BufferCurrentMod", {
    fg = palette.yellow.base,
    bg = palette.bg3
  })
  vim.api.nvim_set_hl(0, "BufferCurrentSign", {
    fg = palette.bg1,
    bg = palette.bg3
  })
  vim.api.nvim_set_hl(0, "BufferCurrentSignRight", {
    fg = palette.bg1,
    bg = palette.bg3
  })
  vim.api.nvim_set_hl(0, "BufferCurrentTarget", {
    bg = palette.bg3
  })
  vim.api.nvim_set_hl(0, "BufferVisible", {
    fg = palette.fg2,
    bg = palette.bg1
  })
  vim.api.nvim_set_hl(0, "BufferVisibleIndex", {
    fg = palette.fg3,
    bg = palette.bg1
  })
  vim.api.nvim_set_hl(0, "BufferVisibleSign", {
    fg = palette.bg1,
    bg = palette.bg0
  })
  vim.api.nvim_set_hl(0, "BufferVisibleSignRight", {
    fg = palette.bg1,
    bg = palette.bg0
  })
  vim.api.nvim_set_hl(0, "BufferVisibleMod", {
    fg = palette.yellow.dim,
    bg = palette.bg1
  })
  -- Grupos adicionales importantes
  vim.api.nvim_set_hl(0, "BufferTabpages", {
    fg = palette.cyan.bright,
    bg = palette.bg0
  })
  vim.api.nvim_set_hl(0, "BufferTabpageFill", {
    fg = palette.bg0,
    bg = palette.bg0
  })
  vim.api.nvim_set_hl(0, "BufferOffset", {
    bg = palette.bg0
  })
end

-- Autocmd to reload buffer colors on change of colorscheme
vim.api.nvim_create_autocmd("User", {
  pattern = "NightfoxReload",
  callback = setup_barbar_highlights
})

-- Autocmd to set colors based on colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local themes = {
      nightfox = true,
      duskfox = true,
      dawnfox = true,
      dayfox = true,
      nordfox = true,
      terafox = true,
      carbonfox = true,
    }
    if vim.g.colors_name and themes[vim.g.colors_name] then
      setup_barbar_highlights()
    end
  end
})

require("barbar").setup({
  icons = {
    buffer_index = true,
    preset = "slanted",
  },
  insert_at_end = true,
})
