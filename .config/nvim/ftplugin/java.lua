local jdtls = require("jdtls")
local util = require("lspconfig.util")
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

-- Configuration
local os_config = ({
  linux = "config_linux",
  darwin = "config_mac",
  win = "config_win",
})[vim.loop.os_uname().sysname:lower()] or "config_linux"

-- If you started neovim within "~/dev/xy/project-1" this would resolve to 'project-1'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls-workspace/" .. project_name

local on_attach = function(client, bufnr)
  -- here only are going mappings of LSP
  local set = vim.keymap.set
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- Disable LSP formatting to use formatter.nvim
  client.server_capabilities.documentFormattingProvider = false

  -- General bindings
  local lsp_buf = vim.lsp.buf
  set("n", "gD", lsp_buf.declaration, bufopts)
  set("n", "gd", lsp_buf.definition, bufopts)
  set("n", "K", lsp_buf.hover, bufopts)
  set("n", "gi", lsp_buf.implementation, bufopts)
  set("n", "<C-k>", lsp_buf.signature_help, bufopts)
  set("n", "<leader>wa", lsp_buf.add_workspace_folder, bufopts)
  set("n", "<leader>wr", lsp_buf.remove_workspace_folder, bufopts)
  set("n", "<leader>wl", function()
    print(vim.inspect(lsp_buf.list_workspace_folders()))
  end, bufopts)
  set("n", "<leader>D", lsp_buf.type_definition, bufopts)
  set("n", "<leader>r", lsp_buf.rename, bufopts)
  set("n", "<leader>ca", lsp_buf.code_action, bufopts)
  set("n", "gr", lsp_buf.references, bufopts)
  set("n", "<leader>f", function()
    lsp_buf.format({ async = true })
  end, bufopts)
  -- Specific mappings of jdtls-nvim
  set("n", "<leader>jo", jdtls.organize_imports, bufopts)
  set("n", "<leader>jv", jdtls.extract_variable, bufopts)
  set("n", "<leader>jc", jdtls.extract_constant, bufopts)
  set("v", "<leader>jv", function() jdtls.extract_variable(true) end, bufopts)
  set("v", "<leader>jc", function() jdtls.extract_constant(true) end, bufopts)
  set("v", "<leader>jm", function() jdtls.extract_method(true) end, bufopts)
  -- set("n", "<leader>jo", "<cmd>lua require'jdtls'.organize_imports()<CR>", bufopts)
  -- set("n", "<leader>jv", "<cmd>lua require'jdtls'.extract_variable()<CR>", bufopts)
  -- set("n", "<leader>jc", "<cmd>lua require'jdtls'.extract_constant()<CR>", bufopts)
  -- set("v", "<leader>jv", "<cmd>lua require'jdtls'.extract_variable(true)<CR>", bufopts)
  -- set("v", "<leader>jc", "<Esc><cmd>lua require'jdtls'.extract_constant(true)<CR>", bufopts)
  -- set("v", "<leader>jm", "<Esc><cmd>lua require'jdtls'.extract_method(true)<CR>", bufopts)
  -- Debug adapter
  -- set("n", "<leader>at", "<cmd>lua require'jdtls'.test_class()<CR>", bufopts)
  -- set("n", "<leader>am", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", bufopts)
  set("n", "<leader>at", jdtls.test_class, bufopts)
  set("n", "<leader>am", jdtls.test_nearest_method, bufopts)
  -- Set DAP up
  jdtls.setup_dap({ hotcodereplace = "auto" })
  jdtls.setup.add_commands()
  -- require("jdtls.setup").add_commands()
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
  -- Handle special cases on Windows
  if vim.fn.has("win32") == 1 then
    path = path:gsub("/", "\\")
  end
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
    util.path.join(home, ".local/share/nvim/mason/packages/jdtls", os_config),
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
      configuration = { updateBuildConfiguration = "interactive" },
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
