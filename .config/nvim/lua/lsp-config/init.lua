-- Global Mappings diagnostics
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "{d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "}d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- on_attach function
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- don't use it if nvim-cmp is installed
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- Border for floating windows
vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "bashls", "cssls", "html", "marksman", "pyright", "lua_ls", "tsserver" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		flags = lsp_flags,
		capabilities = capabilities,
		handlers = handlers,
	})
end

local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	return
end

local nopts = {
	mode = "n", -- NORMAL mode
	-- prefix: use "<leader>f" for example for mapping everything related to finding files
	-- the prefix is prepended to every mapping part of `mappings`
	prefix = "",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local nmappings = {
	["{d"] = { "Go to previous error" },
	["}d"] = { "Go to next error" },
	["gD"] = { ":lua vim.lsp.buf.declaration<CR>", "Go to declaration" },
	["gd"] = { ":lua vim.lsp.buf.definition<CR>", "Go to definition" },
	["gr"] = { ":lua vim.lsp.buf.references<CR>", "Go to references" },
	["K"] = { ":lua vim.lsp.buf.hover<CR>", "Show ubication of file" },
	["gi"] = { ":lua vim.lsp.buf.implementation<CR>", "Go to implementation" },
	["<C-k>"] = { ":lua vim.lsp.buf.signature_help<CR>", "Signature help" },
	["<leader>do"] = { "Float diagnostics" },
	["<leader>q"] = { "Show a list of the buffer diagnostics" },
	["<leader>wa"] = { ":lua vim.lsp.buf.add_workspace_folder<CR>", "Add workspace folder" },
	["<leader>wr"] = { ":lua vim.lsp.buf.remove_workspace_folder<CR>", "Remove workspace folder" },
	["<leader>wl"] = {
		function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end,
		"List folders",
	},
	["<leader>D"] = { ":lua vim.lsp.buf.type_definition<CR>", "Type of definition" },
	["<leader>rn"] = { ":lua vim.lsp.buf.rename<CR>", "Rename on buffer" },
	["<leader>ca"] = { ":lua vim.lsp.buf.code_action<CR>", "Code Actions" },
	["<leader>f"] = {
		function()
			vim.lsp.buf.format({ async = true })
		end,
		"Format",
	},
}

wk.register(nmappings, nopts)
