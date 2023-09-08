-- Bootstrap for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
	-- Treesitter's plugin
	-- Treesitter, easy way to use interface of tree-sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"windwp/nvim-ts-autotag",
			"folke/twilight.nvim",
			"HiPhish/rainbow-delimiters.nvim",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},

	-- Telescope plugins
	-- Telescope itself, a fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope-dap.nvim" },

	-- LSP plugins
	-- Portable package manager for Neovim
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	-- Closing gaps between mason and lsp-config
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"cssls",
					"html",
					"jdtls",
					"marksman",
					"pyright",
					"lua_ls",
					"tsserver",
				},
				automatic_installation = true,
			})
		end,
	},
	-- Closing gaps between mason and nvim-dap
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "bash", "js", "python", "javatest", "javadbg" },
				automatic_installation = true,
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
	-- Specific language servers support
	{ "mfussenegger/nvim-jdtls" },
	-- Linter
	{ "mfussenegger/nvim-lint" },
	-- Formatter
	{ "mhartington/formatter.nvim" },

	-- DAP plugins
	{ "mfussenegger/nvim-dap" },
	{ "mfussenegger/nvim-dap-python" },
	{ "rcarriga/nvim-dap-ui" },
	{ "folke/neodev.nvim", opts = { library = { plugins = { "nvim-dap-ui" }, types = true } } },
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
				highlight_changed_variables = false,
				all_frames = true,
			})
		end,
	},
	{
		"LiadOz/nvim-dap-repl-highlights",
		config = function()
			require("nvim-dap-repl-highlights").setup()
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	-- nvim-cmp, completion plugin
	{ "hrsh7th/nvim-cmp" },
	{ "onsails/lspkind.nvim" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "ray-x/cmp-treesitter" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "lukas-reineke/cmp-under-comparator" },

	-- Colorscheme
	{
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				styles = {
					comments = "italic",
					keywords = "bold",
					types = "italic,bold",
				},
			})
		end,
	},
	-- Notify, fancy notification manager for Neovim
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				-- Animation style
				stages = "slide",
			})
		end,
	},
	{
		"mrded/nvim-lsp-notify",
		config = function()
			require("lsp-notify").setup({
				notify = require("notify"),
				icons = {
					spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
					done = "󰗖",
				},
			})
		end,
	},
	-- Feline, a minimal, stylish and customizable statusline
	{ "freddiehaddad/feline.nvim" },
	-- Bufferline, snazzy buffer line (with tabpage integration) for Neovim
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	-- Gitsigns, super fast git decorations
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	-- Comment.nvim, powerfull and smart commenting plugin
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
	-- Leap, motion plugin
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	-- Vim-repeat, dot command to repeat some actions (principally Leap)
	{ "tpope/vim-repeat" },
	-- Autopair, autoclose parenthesis
	{ "windwp/nvim-autopairs", event = "InsertEnter" },
	-- Toggleterm, plugin to persist and toggle multiple terminals during an editting session
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<A-t>]],
			direction = "tab",
		},
	},
	-- Neoclip, clipboard manager for Neovim
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
	},
	-- Marks, a better experience for interacting with Vim marks
	{ "chentoast/marks.nvim" },
	-- Greeter, fast and fully programmable
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- Glow, preview markdown code directly on Neovim
	{
		"ellisonleao/glow.nvim",
		cmd = "Glow",
		config = function()
			require("glow").setup({})
		end,
	},
	-- Whichkey, displays a pop-up with possible key bindings of the command you start typing
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			window = {
				border = "double",
				position = "top",
			},
			layout = {
				align = "center",
			},
		},
	},

	-- Nvim-tree, a file explorer for Neovim
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"echasnovski/mini.base16",
		},
	},
	{ "antosha417/nvim-lsp-file-operations" },
})
