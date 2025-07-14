-- Function to modify the colorscheme of barbar
local function setup_barbar_highlights()
  local palette = require("nightfox.palette").load(vim.g.colors_name)                                                     -- Get the current colorscheme's palette
  local buffers_status = { "Current", "Alternate", "Inactive", "Visible" }                                                -- Posible buffer status
  local buffers_parts = { "ADDED", "CHANGED", "DELETED", "ERROR", "WARN", "Sign", "SignRight", "Index", "Target", "Mod" } -- The only importants parts
  local bg_current = palette.bg3 -- Background for Current status
  local bg_others = palette.bg1 -- Background for any other status
  local colors_current = {
    added = palette.green.bright,
    changed = palette.magenta.bright,
    deleted = palette.pink.bright,
    error = palette.red.bright,
    warn = palette.orange.bright,
    sign = palette.bg1,
    signright = palette.bg1,
    index = palette.blue.bright,
    target = palette.red.dim,
    mod = palette.yellow.bright,
  }
  local colors_other_status = {
    added = palette.green.dim,
    changed = palette.magenta.dim,
    deleted = palette.pink.dim,
    error = palette.red.dim,
    warn = palette.orange.dim,
    sign = palette.bg0,
    signright = palette.bg0,
    index = palette.blue.dim,
    target = palette.red.bright,
    mod = palette.yellow.dim,
  }

  -- Father Highlights
  for _, stat in ipairs(buffers_status) do
    local group = "Buffer" .. stat
    if stat ~= "Current" then
      vim.api.nvim_set_hl(0, group, { bg = bg_others, fg = palette.fg3 })
    else
      vim.api.nvim_set_hl(0, group, { bg = bg_current, fg = palette.fg1, bold = true, italic = true })
    end
  end

  -- Set Highlights for the other buffer status
  for _, stat in ipairs(buffers_status) do
    for _, part in ipairs(buffers_parts) do
      local color = part:lower()
      local group = "Buffer" .. stat .. part
      if stat ~= "Current" then
        vim.api.nvim_set_hl(0, group, { bg = bg_others, fg = colors_other_status[color] })
      else
        vim.api.nvim_set_hl(0, group, { bg = bg_current, fg = colors_current[color] })
      end
    end
  end

  -- Highlights for special fields
  vim.api.nvim_set_hl(0, "BufferOffset", { bg = palette.bg0, fg = palette.bg0 })
  vim.api.nvim_set_hl(0, "BufferScrollArrow", { bg = palette.bg1, fg = palette.cyan.bright })
  vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = palette.bg0 })
  vim.api.nvim_set_hl(0, "BufferTabpages", { bg = palette.bg1, fg = palette.comment })
  vim.api.nvim_set_hl(0, "BufferTabpageSep", { bg = palette.bg0, fg = palette.bg2 })
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
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
      [vim.diagnostic.severity.WARN] = { enabled = true },
      [vim.diagnostic.severity.INFO] = { enabled = false },
      [vim.diagnostic.severity.HINT] = { enabled = false },
    },
    gitsigns = {
      added = { enabled = true, icon = '+' },
      changed = { enabled = true, icon = '~' },
      deleted = { enabled = true, icon = '-' },
    },
    pinned = { button = " ", filename = true },
    preset = "slanted",
  },
  insert_at_end = true,
})
