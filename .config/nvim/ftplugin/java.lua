-- Verbose configuration
local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local home = os.getenv('HOME')
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
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
	vim.keymap.set("n", "<C-o>", ":lua require'jdtls'.organize_imports()<CR>", bufopts)
	vim.keymap.set("n", "<leader>ev", ":lua require('jdtls').extract_variable()<CR>", bufopts)
	vim.keymap.set("n", "<leader>ec", ":lua require('jdtls').extract_constant()<CR>", bufopts)
	vim.keymap.set("v", "crv", ":lua require('jdtls').extract_variable(true)<CR>", bufopts)
	vim.keymap.set("v", "crc", "<Esc>:lua require('jdtls').extract_constant(true)<CR>", bufopts)
	vim.keymap.set("v", "crm", "<Esc>:lua require('jdtls').extract_method(true)<CR>", bufopts)

	-- Nvim-dap
	vim.keymap.set("n", "<leader>df", ":lua require'jdtls'.test_class()<CR>", bufopts)
	vim.keymap.set("n", "<leader>dn", ":lua require'jdtls'.test_nearest_method()<CR>", bufopts)
	-- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
	-- you make during a debug session immediately.
	-- Remove the option if you do not want that.
	-- You can use the `JdtHotcodeReplace` command to trigger it manually
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("jdtls.setup").add_commands()
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {
	vim.fn.glob(
		home .. "/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
		true
	),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/nvim/vscode-java-test/server/*.jar", true), "\n"))

-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace") .. project_name

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {

		-- 💀
		"java", -- or '/path/to/java17_or_newer/bin/java'
		-- home .. "/.local/share/nvim/mason/bin/jdtls"
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		home .. "/.config/nvim/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		home .. "/.config/nvim/jdtls/config_linux/",
		-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},
	on_attach = on_attach,
	capabilities = capabilities,
	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
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
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
				updateBuildConfiguration = "interactive",
				-- Indicate different runtimes when your project uses more than one version of Java
				-- runtimes = {
				-- 	{
				-- 		name = "JavaSE-17",
				-- 		path = "/usr/lib/jvm/java-17-openjdk",
				-- 	},
				-- },
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
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = true,
				settings = {
					-- Use Google Java style guidelines for formatting
          -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
          -- and place it in the ~/.local/share/eclipse directory
          url = home .. "/.local/share/eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
				},
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
        "jdk.*", "sun.*",
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
	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles,
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	L = {
		name = "Java",
		o = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
		v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
		c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant" },
		t = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "Test Method" },
		T = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test Class" },
		u = { "<Cmd>JdtUpdateConfig<CR>", "Update Config" },
	},
}

local vmappings = {
	L = {
		name = "Java",
		v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
		c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant" },
		m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
	},
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
