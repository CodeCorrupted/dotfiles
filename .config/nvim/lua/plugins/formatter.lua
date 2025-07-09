-- Provides the Format, FormatWrite, FormatLock and FormatWriteLock commands
require("formatter").setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    sh = {
      require("formatter.filetypes.sh").shfmt,
    },
    css = {
      require("formatter.filetypes.css").prettierd,
    },
    html = {
      require("formatter.filetypes.html").prettierd,
    },
    javascript = {
      require("formatter.filetypes.javascript").prettierd,
    },
    json = {
      require("formatter.filetypes.json").prettierd,
    },
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
    markdown = {
      require("formatter.filetypes.markdown").prettierd,
    },
    python = {
      require("formatter.filetypes.python").black,
    },
    ["*"] = {
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
})

-- Format on save
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
  group = "__formatter__",
  pattern = { "*.sh", "*.css", "*.html", "*.js", "*.json", "*.md", "*.py", "*.ts" },
  command = ":FormatWrite",
})
