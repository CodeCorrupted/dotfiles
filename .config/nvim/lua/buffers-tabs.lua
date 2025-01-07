local bufferline = require("bufferline")
bufferline.setup({
	options = {
		style_preset = bufferline.style_preset.minimal,
		numbers = "ordinal",
		indicator = {
			style = "underline",
		},
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		separator_style = "slant",
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		sort_by = "insert_at_end",
	},
})
