local wk = require("which-key")

wk.add({
  {
    mode = { "n" },
    -- Buffer mappings
    { "<A-,>", "<cmd>BufferPrevious<CR>", desc = "Go to previous buffer" },
    { "<A-.>", "<cmd>BufferNext<CR>", desc = "Go to next buffer" },
    { "<A-{>", "<cmd>BufferMovePrevious<CR>", desc = "Move to previous buffer" },
    { "<A-}>", "<cmd>BufferMoveNext<CR>", desc = "Move to next buffer" },
    { "<A-1>", "<cmd>BufferGoto 1<CR>", desc = "Jump to buffer 1" },
    { "<A-2>", "<cmd>BufferGoto 2<CR>", desc = "Jump to buffer 2" },
    { "<A-3>", "<cmd>BufferGoto 3<CR>", desc = "Jump to buffer 3" },
    { "<A-4>", "<cmd>BufferGoto 4<CR>", desc = "Jump to buffer 4" },
    { "<A-5>", "<cmd>BufferGoto 5<CR>", desc = "Jump to buffer 5" },
    { "<A-6>", "<cmd>BufferGoto 6<CR>", desc = "Jump to buffer 6" },
    { "<A-7>", "<cmd>BufferGoto 7<CR>", desc = "Jump to buffer 7" },
    { "<A-8>", "<cmd>BufferGoto 8<CR>", desc = "Jump to buffer 8" },
    { "<A-9>", "<cmd>BufferGoto 9<CR>", desc = "Jump to buffer 9" },
    { "<A-0>", "<cmd>BufferLast<CR>", desc = "Jump to last buffer" },
    { "<A-c>", "<cmd>BufferClose<CR>", desc = "Close buffer" },
    { "<C-p>", "<cmd>BufferPick<CR>", desc = "Pick buffer" },
    { "<C-S-p>", "<cmd>BufferPickDelete<CR>", desc = "Close picked buffer" },
    { "<leader>bp", "<cmd>BufferPin<CR>", desc = "Pin/Unpin buffer" },
    { "<leader>bb", "<cmd>BufferOrderByBufferNumber<CR>", desc = "Order buffers by buffer number" },
    { "<leader>bn", "<cmd>BufferOrderByName<CR>", desc = "Order buffers by buffer's name" },
    { "<leader>bd", "<cmd>BufferOrderByDirectory<CR>", desc = "Order buffers by buffer's directory" },
    { "<leader>bl", "<cmd>BufferOrderByLanguage<CR>", desc = "Order buffers by buffer's language" },
    { "<leader>bw", "<cmd>BufferOrderByWindowNumber<CR>", desc = "Order buffers by buffer's window number" },
    -- Editor mappings
    { "<F2>",       "<cmd>w!<CR>",                                    desc = "Save file" },
    { "<F3>",       "<cmd>q!<CR>",                                    desc = "Quit file" },
    -- Diagnostics mappings
    { "<leader>e",  group = "Diagnostics" },
    { "<leader>eo", vim.diagnostic.open_float,                        desc = "Open a floating window of the error on current line" },
    { "<leader>es", vim.diagnostic.setloclist,                        desc = "Gives a list of all the errors on current file" },
    -- Change Colorscheme
    { "<C-c>",      "<cmd>lua SwitchColorscheme()<CR>",               desc = "Change current colorscheme" },
    -- Treesitter mappings
    {
      "{t",
      function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end,
      desc = "Go to the top of the function on spec",
      group = "Treesitter",
    },
    { "<leader>l",   "<cmd>Twilight<CR>",                                desc = "Focus on spec with treesitter" },
    -- Terminal on Neovim
    { "<A-t>",     desc = "Open a Terminal" },
    -- Telescope
    { "<leader>t",   group = "Telescope" },
    { "<leader>tb",  "<cmd>Telescope file_browser<CR>",                  desc = "File browser" },
    { "<leader>tc",  "<cmd>Telescope neoclip<CR>",                       desc = "Search for yanked text" },
    { "<leader>tf",  "<cmd>Telescope find_files<CR>",                    desc = "Find files" },
    { "<leader>tg",  "<cmd>Telescope live_grep<CR>",                     desc = "Find files using grep" },
    { "<leader>tl",  "<cmd>Telescope luasnip<CR>",                       desc = "Use snippets through Telescope" },
    { "<leader>tn",  "<cmd>Telescope notify<CR>",                        desc = "Show messages of notify" },
    { "<leader>tm",  "<cmd>Telescope media_files<CR>",                   desc = "Find media files" },
    { "<leader>td",  group = "Telescope+DAP" },
    { "<leader>tdc", "<cmd>Telescope dap commands<CR>",                  desc = "DAP commands" },
    { "<leader>tdf", "<cmd>Telescope dap frames<CR>",                    desc = "DAP frames" },
    { "<leader>tdl", "<cmd>Telescope dap list_breakpoints<CR>",          desc = "List of breakpoints" },
    { "<leader>tds", "<cmd>Telescope dap configurations<CR>",            desc = "DAP configurations" },
    { "<leader>tdv", "<cmd>Telescope dap variables<CR>",                 desc = "Show variables" },
    { "Q",           "<cmd>Telescope cmdline<CR>",                       desc = "Run cmdline with Telescope" },
    -- Glow
    { "<leader>g",   "<cmd>Glow<CR>",                                    desc = "Preview current md file" },
  },
})

-- Terminal mappings
function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
