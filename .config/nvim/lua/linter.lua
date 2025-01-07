local lint = require("lint")

lint.linters_by_ft = {
	markdown = { "markdownlint" },
	bash = { "shellcheck" },
	c = { "cpplint" },
	css = { "stylelint" },
	html = { "djlint" },
	java = { "checkstyle" },
	javascript = { "eslint_d" },
	python = { "flake8" },
	typescript = { "eslint_d" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
