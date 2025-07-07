-- some code to not see binaries
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end,
  }):sync()
end
-- this is for change the behavior of <esc> key on telescope
local actions = require("telescope.actions")
local fb_actions = require("telescope._extensions.file_browser.actions")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-u>"] = false,
      },
    },
    buffer_previewer_maker = new_maker,
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    media_files = {
      filetypes = { "png", "jpg", "jpeg", "pdf", "webm" },
      find_cmd = "rg",
    },
    lsp_handlers = {
      code_actions = {
        telescope = require("telescope.themes").get_dropdown({}),
      },
    },
    file_browser = {
      theme = "ivy",
      -- disable netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<A-n>"] = fb_actions.create,
        },
      },
    },
    cmdline = {
      picker = {
        layout_config = {
          width = 120,
          height = 25,
        },
      },
    },
    mappings = {
      complete = "<Tab>",
      run_selection = "<C-CR>",
      run_input = "<CR>",
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("media_files")
require("telescope").load_extension("lsp_handlers")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("dap")
require("telescope").load_extension("luasnip")
require("telescope").load_extension("notify")
require("telescope").load_extension("neoclip")
require("telescope").load_extension("ui-select")
