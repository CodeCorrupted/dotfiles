return {
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

  -- Greeter
  {
    "goolord/alpha-nvim",
    lazy = false,
    event = "VimEnter",
    config = function()
      require("plugins.alpha")
    end
  },

  -- Treesitter plugins
  -- Features based on tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- When the wiki have all the info up-to-date, I'll change this to main.
    branch = "master",
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.treesitter")
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
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            }
          }
        },
      },
      {
      "neovim/nvim-lspconfig",
      config = function ()
        require("plugins.lspconfig")
      end
      },
    },
    opts = {
      ensure_installed = {
        "angularls",
        "bashls",
        "cssls",
        "html",
        "jdtls",
        "marksman",
        "pyright",
        "lua_ls",
        "jsonls",
      },
      automatic_installation = true,
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "bash", "js", "python", "javatest", "javadbg" },
      automatic_installation = true,
    },
  },
  -- Linter
  {
    "mfussenegger/nvim-lint",
    config = function ()
      require("plugins.lint")
    end
  },
  {
    "rshkarin/mason-nvim-lint",
    opts = {
      ensure_installed = {
        "markdownlint",
        "shellcheck",
        "stylelint",
        "djlint",
        "eslint_d",
        "flake8",
        "jsonlint"
      },
      automatic_installation = true,
    },
  },
  -- Specific language servers support
  { "mfussenegger/nvim-jdtls" },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  { "joeveiga/ng.nvim" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  -- Formatter
  {
    "mhartington/formatter.nvim",
    config = function ()
      require("plugins.formatter")
    end
  },

  -- DAP plugins
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
      "LiadOz/nvim-dap-repl-highlights",
    },
    config = function ()
      require("plugins.dap")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      commented = true,
      highlight_changed_variables = true,
      all_frames = true,
    },
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
}
