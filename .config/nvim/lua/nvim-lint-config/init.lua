require('lint').linters_by_ft = {
  markdown = {'markdownlint',},
	bash = {"shellcheck"},
	css = {"stylelint"},
	html = {"djlint"},
	java = {"checkstyle"},
	javascript = {"eslint_d"},
	-- lua = {"luacheck"},
	python = {"flake8"},
	typescript = {"eslint_d"},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
