local jdtls = require("jdtls")
local home = os.getenv("HOME")

-- If you started neovim within "~/dev/xy/project-1" this would resolve to 'project-1'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls-workspace/" .. project_name

local on_attach = function(client, bufnr)
	-- here only are going mappings of LSP
	local set = vim.keymap.set
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- Disable LSP formatting to use formatter.nvim
	client.server_capabilities.documentFormattingProvider = true

	-- General bindings
	set("n", "gD", vim.lsp.buf.declaration, bufopts)
	set("n", "gd", vim.lsp.buf.definition, bufopts)
	set("n", "K", vim.lsp.buf.hover, bufopts)
	set("n", "gi", vim.lsp.buf.implementation, bufopts)
	set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
	set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	set("n", "gr", vim.lsp.buf.references, bufopts)
	set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
	-- Specific mappings of jdtls-nvim
	set("n", "<leader>jo", "<cmd>lua require'jdtls'.organize_imports()<CR>", bufopts)
	set("n", "<leader>jv", "<cmd>lua require'jdtls'.extract_variable()<CR>", bufopts)
	set("n", "<leader>jc", "<cmd>lua require'jdtls'.extract_constant()<CR>", bufopts)
	set("v", "<leader>jv", "<cmd>lua require'jdtls'.extract_variable(true)<CR>", bufopts)
	set("v", "<leader>jc", "<Esc><cmd>lua require'jdtls'.extract_constant(true)<CR>", bufopts)
	set("v", "<leader>jm", "<Esc><cmd>lua require'jdtls'.extract_method(true)<CR>", bufopts)
	-- Debug adapter
	set("n", "<leader>at", "<cmd>lua require'jdtls'.test_class()<CR>", bufopts)
	set("n", "<leader>am", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", bufopts)
	-- Adding commands from jdtls-nvim and nvim-dap
	jdtls.setup_dap({ hotcodereplace = "auto" })
	require("jdtls.setup").add_commands()
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local bundles = {
	vim.fn.glob(
		home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar",
		true
	),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar", true), "\n"))

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
		-- "-Xmx2g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		home
			.. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",

		"-data",
		workspace_dir,
	},
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},
			format = {
				enabled = true,
				insertSpaces = true,
				tabSize = 2,
			},
		},
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
			importOrder = {
				"java",
				"javax",
				"com",
				"org",
			},
		},
		contentProvider = { preferred = "fernflower" },
		extendedClientCapabilities = extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			hashCodeEquals = {
				useJava7Objects = true,
			},
			useBlocks = true,
		},
	},
	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		bundles = bundles,
	},
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the 'root_dir'
require("jdtls").start_or_attach(config)

-- Auto-formatting on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.java",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
