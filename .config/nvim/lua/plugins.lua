-- Bootstrap for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- Set Space as mapleader
-- This is the recommended way to do it
vim.g.mapleader = " "

require("lazy").setup({
  -- Colorscheme
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
  },

  -- Treesitter plugins
  -- Funcionalities based on tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- When the wiki have all the info up-to-date, I'll change this to main.
    branch = "master",
    lazy = false,
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "bash", "css", "html", "java", "javascript", "json", "lua", "python", "sql", "typescript" },
        sync_install = true,
        auto_install = true,
        highlight = {
          enable = true,
        },
        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
          },
          highlight_current_scope = { enable = true },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = false,
              list_definitions = false,
              list_definitions_toc = false,
              goto_next_usage = "<a-n>",
              goto_previous_usage = "<a-p>",
            }
          },
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-context",
      "HiPhish/rainbow-delimiters.nvim",
      "folke/twilight.nvim",
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = {
          enable_autocmd = false,
        },
      },
    },
  },
  -- Comment plugin
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- LSP Plugins
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        }
      }
    },
    -- config = function()
    --   require("mason").setup({
    --     ui = {
    --       icons = {
    --         package_installed = "✓",
    --         package_pending = "➜",
    --         package_uninstalled = "✗",
    --       },
    --     },
    --   })
    -- end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "clangd",
          "cssls",
          "html",
          "jdtls",
          "marksman",
          "pyright",
          "lua_ls",
          "ts_ls",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "bash", "cpptools", "js", "python", "javatest", "javadbg" },
        automatic_installation = true,
      })
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    config = function()
      require("mason-nvim-lint").setup({
        ensure_installed = {
          "markdownlint",
          "shellcheck",
          "stylelint",
          "djlint",
          "checkstyle",
          "eslint_d",
          "flake8",
          "cpplint",
        },
        automatic_installation = true,
      })
    end,
  },
  { "neovim/nvim-lspconfig" },
  -- Specific language servers support
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  -- Linter
  { "mfussenegger/nvim-lint" },
  -- Formatter
  { "mhartington/formatter.nvim" },

  -- DAP plugins
  { "mfussenegger/nvim-dap-python" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
  },
  {
    "folke/neodev.nvim",
    opts = {
      library = {
        plugins = { "nvim-dap-ui" },
        types = true,
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({
        commented = true,
        highlight_changed_variables = true,
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
    varsion = "v2.3",
    build = "make install_jsregexp",
  },

  -- Completion plugins
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
  },
  { "onsails/lspkind.nvim" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  { "ray-x/cmp-treesitter" },
  { "lukas-reineke/cmp-under-comparator" },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {
      enable_check_bracket_line = false,
      check_ts = true,
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-lua/popup.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-tree/nvim-web-devicons",
      "gbrlsnchs/telescope-lsp-handlers.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "benfowler/telescope-luasnip.nvim",
      "jonarrien/telescope-cmdline.nvim",
    },
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-telescope/telescope-dap.nvim" },


  -- Which-key, plugin to manage mappings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      win = {
        border = "double",
      },
      layout = {
        align = "center",
      },
    },
  },
  -- Bufferline,GUI improvement for buffers and tabs
  { "akinsho/bufferline.nvim",  version = "*" },
  -- Notification manager
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "slide",
      })
    end,
  },
  -- Git decorations
  { "lewis6991/gitsigns.nvim" },
  -- Feline, status bar
  { "freddiehaddad/feline.nvim" },
  -- Leap, a motion improvement for neovim
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
    dependencies = {
      "tpope/vim-repeat", -- for dot repeat
    },
  },
  -- Terminal on editor
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<A-t>]],
      direction = "tab",
    },
  },
  -- Clipboard
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
    end,
  },
  -- Improvement to vim marks
  { "chentoast/marks.nvim" },
  -- Previewer for md files
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- Greeter
  { "goolord/alpha-nvim" },
})
