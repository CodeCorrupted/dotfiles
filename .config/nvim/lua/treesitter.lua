require("nvim-treesitter.configs").setup({
	-- A list of parser names
	ensure_installed = { "bash", "c", "css", "html", "java", "javascript", "json", "lua", "python", "sql", "typescript" },

	-- install parsers synchronously (only applied to 'ensure_installed')
	sync_install = true,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	highlight = {
		enable = true,
	},

	-- treesitter refactor settings
	refactor = {
		highlight_definitions = {
			enable = true,
			-- Set it to false if you have an 'updatetime' of ~100
			clear_on_cursor_move = true,
		},
		highlight_current_scope = { enable = true },
	},
})
