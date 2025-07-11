local lspconfig = require("lspconfig")
local float_style = require("float_style")
local wk = require("which-key")

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
  -- Register mappings on which-key
  local lsp_buf = vim.lsp.buf
  wk.add({
    {
      mode = { "n" },
      { "<leader>w", group = "Workspace Actions" },
      { "<leader>wa", lsp_buf.add_workspace_folder , desc = "Add the folder at path of workspace folders" },
      { "<leader>wr", lsp_buf.remove_workspace_folder , desc = "Remove the folder at path from workspace folders" },
      { "<leader>wl", function()
        print(vim.inspect(lsp_buf.list_workspace_folders()))
      end, desc = "List workspace folders" },
      { "<leader>f", function()
        lsp_buf.format({ async = true })
      end, desc = "Formats the buffer using the attached LSP" },
      { "<leader>ca", lsp_buf.code_action, desc = "Selects a code action available at cursor position" },
      { "<leader>r", lsp_buf.rename, desc = "Renames all references to the symbol under the cursor" },
      { "<leader>D", lsp_buf.type_definition, desc = "Jumps to the definition of the type of the symbol under the cursor" },
      { "gd", lsp_buf.definition, desc = "Jumps to the definition of the symbol under the cursor" },
      { "gD", lsp_buf.declaration, desc = "Jumps to the declaration of the symbol under the cursor" },
      { "gr", lsp_buf.references, desc = "Lists all the references to the symbol under the cursor" },
      { "gi", lsp_buf.implementation, desc = "Lists all the implementations for the symbol under the cursor" },
      { "K", lsp_buf.hover, desc = "Displays information of the symbol under the cursor" },
      { "<C-k>", lsp_buf.signature_help, desc = "Displays signature information of the symbol under the cursor" },
    },
  }, { buffer = bufnr })
end


-- Enable some languages servers with the aditional completion capabilities and mappings
local servers = { "bashls", "cssls", "html", "jsonls", "marksman", "lua_ls", "pyright" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- TypeScript configuration
require("typescript-tools").setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set('n', 'gs', ':TSToolsOrganizeImports<CR>', opts)
    vim.keymap.set('n', 'gR', ':TSToolsRenameFile<CR>', opts)
    vim.keymap.set('n', 'gI', ':TSToolsAddMissingImports<CR>', opts)
    wk.add({
      {
        mode = { "n" },
        { "gs", desc = "Organize imports" },
        { "gR", desc = "Rename File" },
        { "gI", desc = "Add Missing Imports" },
      }
    })
  end,
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
    },
    tsserver_format_options = {
      insertSpaceAfterCommaDelimiter = true,
      insertSpaceAfterConstructor = false,
      semicolons = "insert",
    },
    separate_diagnostic_server = true,
    publish_diagnostic_on = "change",
  },
})

-- JavaScript configuration
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  filetypes = { "javascript" },
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  }
})

-- Angular configuration
lspconfig.angularls.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    local opts = { noremap = true, silent = true }
    local ng = require("ng");
    vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, opts)
    vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, opts)
    vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)
    wk.add({
      {
        mode = { "n" },
        { "<leader>a",  group = "Angular Actions" },
        { "<leader>at", desc = "Go to template for component" },
        { "<leader>ac", desc = "Go to component with template file" },
        { "<leader>aT", desc = "Get template" },
      }
    })
  end,
  capabilities = capabilities,
})
