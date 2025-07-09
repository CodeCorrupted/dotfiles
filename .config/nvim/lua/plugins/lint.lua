local lint = require("lint")

lint.linters_by_ft = {
  markdown = { "markdownlint" },
  bash = { "shellcheck" },
  css = { "stylelint" },
  html = { "djlint" },
  javascript = { "eslint_d" },
  json = { "jsonlint" },
  python = { "flake8" },
  typescript = { "eslint_d" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})
