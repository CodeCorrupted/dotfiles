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
        config = function()
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
    config = function()
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
    config = function()
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
    config = function()
      require("plugins.dap")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function()
      require("plugins.dap_ui")
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      commented = true,
      highlight_changed_variables = true,
      all_frames = true,
      virtual_text_pos = 'inline',
    },
  },
  {
    "LiadOz/nvim-dap-repl-highlights",
    opts = {},
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },

  -- Completion plugins
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "ray-x/cmp-treesitter",
      "lukas-reineke/cmp-under-comparator",
    },
    config = function()
      require("plugins.cmp")
    end
  },
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
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "gbrlsnchs/telescope-lsp-handlers.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "benfowler/telescope-luasnip.nvim",
      "jonarrien/telescope-cmdline.nvim",
    },
    config = function()
      require("plugins.telescope")
    end
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
  -- Barbar, a tabline improvement
  {
    "romgrk/barbar.nvim",
    dependencies = {
      {
        "lewis6991/gitsigns.nvim",
        config = function()
          require("plugins.gitsigns")
        end
      },
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require("plugins.barbar")
    end,
    version = '^1.0.0',
  },
  -- Notification manager
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        render = "compact",
        stages = "slide",
      })
    end,
  },
  -- Lualine, status bar
  {
    "nvim-lualine/lualine.nvim",
    opts = true,
  },
  -- Leap, a motion improvement for neovim
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
      require('leap').opts.preview_filter =
          function(ch0, ch1, ch2)
            return not (
              ch1:match('%s') or
              ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
            )
          end
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
      direction = "float",
      float_opts = {
        border = "curved",
        title_pos = "center",
      },
    },
  },
  -- Clipboard
  {
    "AckslD/nvim-neoclip.lua",
    config = true,
  },
  -- Improvement to vim marks
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Improvement to session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
    }
  },
  -- Previewer for md files
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    opts = {
    },
  },
}
