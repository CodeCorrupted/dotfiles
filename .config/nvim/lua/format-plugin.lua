-- Utilities for creating configurations
-- local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock and FormatWriteLock commands
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		sh = {
			require("formatter.filetypes.sh").shfmt,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		css = {
			require("formatter.filetypes.css").prettierd,
		},
		html = {
			require("formatter.filetypes.html").prettierd,
		},
		java = {
			function()
				return {
					exe = "java",
					args = {
						"-jar",
						os.getenv("HOME")
							.. "/.local/share/nvim/mason/packages/google-java-format/google-java-format-1.25.2-all-deps.jar",
						"--aosp",
						vim.api.nvim_buf_get_name(0),
					},
					stdin = true,
				}
			end,
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
		typescript = {
			require("formatter.filetypes.typescript").prettierd,
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
	pattern = { "*.sh", "*.c", "*.css", "*.html", "*.js", "*.json", "*.md", "*.py", "*.ts" },
	command = ":FormatWrite",
})
