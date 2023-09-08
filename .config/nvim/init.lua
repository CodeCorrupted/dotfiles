-- Plugins for Neovim
require("lazy-nvim")

-- General settings for Neovim
require("settings")

-- Mappings
require("mappings")

-- Bufferline & Tabline
require("bufferline-nvim")

-- Terminal
require("toggleterm-config")

-- Treesitter hilighting
require("treesitter-config")

-- Telescope, fuzzy finder
require("telescope-config")

-- Autocompletion
require("nvim-cmp-config")

-- LSP
require("lsp-config")

-- DAP, debuggers
require("dap-config")
require("dapui-config")

-- Status bar
require("feline-config")

-- Autopairs Plugin
require("autopairs-config")

-- Greeter
require("alpha-config")

-- Linter
require("nvim-lint-config")

-- Formatter
require("formatter-config")

-- Marks
require("marks-config")

-- Explorer
require("nvim-tree-config")
