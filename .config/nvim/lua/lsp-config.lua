local lspconfig = require("lspconfig")
local float_style = require("float_style")

-- Appy color and borders to LSP
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = float_style.setup_colors
})

-- Set borders to floating windows
float_style.setup_colors()
float_style.setup_lsp_borders()

-- Add aditional capabilities suported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- on_attach function
-- This function only map the following keys after the language
-- server attaches to the current buffer
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
  -- Register on which-key those mappings
  local wk = require("which-key")
  wk.register({
    { "<leader>w", group = "Workspace Actions" },
    { "<leader>wa", desc = "Add the folder at path of workspace folders" },
    { "<leader>wr", desc = "Remove the folder at path from workspace folders" },
    { "<leader>wl", desc = "List workspace folders" },
    { "<leader>f", desc = "Formats the buffer using the attached LSP" },
    { "<leader>ca", desc = "Selects a code action available at cursor position" },
    { "<leader>r", desc = "Renames all references to the symbol under the cursor" },
    { "<leader>D", desc = "Jumps to the definition of the type of the symbol under the cursor" },
    { "gd", desc = "Jumps to the definition of the symbol under the cursor" },
    { "gD", desc = "Jumps to the declaration of the symbol under the cursor" },
    { "gr", desc = "Lists all the references to the symbol under the cursor" },
    { "gi", desc = "Lists all the implementations for the symbol under the cursor" },
    { "K", desc = "Displays information of the symbol under the cursor" },
    { "<C-k>", desc = "Displays signature information of the symbol under the cursor" },
  })
end


-- Enable some languages servers with the aditional completion capabilities and mappings
local servers = { "bashls", "cssls", "html", "marksman", "pyright", "lua_ls", "ts_ls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
