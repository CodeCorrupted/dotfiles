local jdtls = require("jdtls")
local home = os.getenv("HOME")

-- Get the jdtls JAR from mason
local function find_equinox_launcher()
  local launchers = vim.split(
    vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"), "\n")
  table.sort(launchers, function(a, b) return a > b end) -- Order and get the most recent version
  return launchers[1]
end

local equinox_launcher = find_equinox_launcher()
if not equinox_launcher then
  error("No se encontró el archivo JAR del launcher de JDTLS")
end

-- If you started neovim within "~/dev/xy/project-1" this would resolve to 'project-1'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls-workspace/" .. project_name

local on_attach = function(client, bufnr)
  -- true: use jdtls formatter
  client.server_capabilities.documentFormattingProvider = true

  -- Register on which-key general mappings
  local lsp_buf = vim.lsp.buf
  local wk = require("which-key")
  wk.add({
    {
      mode = { "n" },
      -- LSP general mappings
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
      -- Specific jdtls mappings
      { "<leader>j", group = "Jdtls Mappings" },
      { "<leader>jo", jdtls.organize_imports, desc = "Organize imports" },
      { "<leader>jv", jdtls.extract_variable, desc = "Extract variable" },
      { "<leader>jc", jdtls.extract_constant, desc = "Extract constant" },
      { "<leader>ju", ":JdtUpdateDebugConfig<CR>", desc = "Update debug config of jdtls" },
      -- Debug adpater
      { "<leader>dt", jdtls.test_class, desc = "Test class" },
      { "<leader>dm", jdtls.test_nearest_method, desc = "Test nearest method" },
    },
    {
      mode = { "v" },
      { "<leader>j",  group = "Jdtls" },
      { "<leader>jv", function()
        jdtls.extract_variable()
      end, desc = "Extract constant" },
      { "<leader>jc", function()
        jdtls.extract_constant()
      end, desc = "Extract method" },
      { "<leader>jm", function()
        jdtls.extract_method()
      end, desc = "Extract variable" },
    },
  }, {buffer = bufnr})
end

-- Extend capabilities
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Bundles
local function join_path(...)
  local parts = { ... }
  local path = table.concat(parts, "/")
  -- Normalize paths (delete double slides)
  path = path:gsub("/+", "/")
  return path
end

local function get_jdtls_bundles()
  local debug_path = join_path(home, ".local/share/nvim/mason/share/java-debug-adapter/*.jar")
  local test_path = join_path(home, ".local/share/nvim/mason/share/java-test/*.jar")
  local debug_jars = vim.fn.glob(debug_path, false, true) -- El tercer argumento (true) devuelve una lista
  local test_jars = vim.fn.glob(test_path, false, true)
  -- Join both tables
  local bundles = {}
  vim.list_extend(bundles, debug_jars)
  vim.list_extend(bundles, test_jars)
  return bundles
end

-- Configuration of nvim-jdtls
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar", equinox_launcher,
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
    "-data",
    workspace_dir,
  },
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "/usr/lib/jvm/java-8-openjdk/"
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk/"
          },
          {
            name = "JavaSE-21",
            path = "/usr/lib/jvm/java-21-openjdk/"
          },
        },
        compiler = {
          lint = {
            nullReference = "error",
            potentialNullReference = "warning",
            redundantNullCheck = "warning",
          },
        },
      },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      inlayHints = { parameterNames = { enabled = "all" } },
      format = { enabled = true, insertSpaces = true, tabSize = 2 },
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        importOrder = { "java", "javax", "com", "org" },
      },
      contentProvider = { preferred = "fernflower" },
      sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
      codeGeneration = {
        toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
        hashCodeEquals = { useJava7Objects = true },
        useBlocks = true,
      },
      extendedClientCapabilities = extendedClientCapabilities,
      errors = {
        incompleteClasspath = {
          severity = "warning",
        }
      },
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = get_jdtls_bundles(),
  },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the 'root_dir'
local safe_require = require("jdtls").start_or_attach
if safe_require then
  safe_require(config)
else
  vim.notify("jdtls no está disponible", vim.log.levels.ERROR)
end

-- Auto-formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.java",
  callback = function()
    if not vim.b.disable_autoformat then
      vim.lsp.buf.format({ async = false, timeout_ms = 5000 })
    end
  end,
})
