local M = {}

M.border = "rounded"

-- Set colors for the floating window
M.setup_colors = function ()
  vim.api.nvim_set_hl(0, "NormalFloat", {bg = '#1f2335'})
  vim.api.nvim_set_hl(0, "FloatBorder", {fg = "white", bg = '#1f2335'})
end

-- Apply border to LSP features
M.setup_lsp_borders = function()
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = M.border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  vim.diagnostic.config({
    float = {
      border = M.border,
      header = "",
      prefix = "",
    }
  })
end

return M
