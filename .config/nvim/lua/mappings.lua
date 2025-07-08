local wk = require("which-key")

wk.add({
  {
    mode = { "n" },
    -- Window mappings
    { "<C-Up>",     "<cmd>resize +2<CR>",          desc = "Add 2pts to horizontal window" },
    { "<C-Down>",   "<cmd>resize -2<CR>",          desc = "Substract 2pts to horizontal window" },
    { "<C-Right>",  "<cmd>vertical resize +2<CR>", desc = "Add 2pts to vertical window" },
    { "<C-Left>",   "<cmd>vertical resize -2<CR>", desc = "Substract 2pts to vertical window" },
    { "<leader>s",  group = "Split" },
    { "<leader>sh", "<cmd>split<CR>",              desc = "Horizontal split window" },
    { "<leader>sv", "<cmd>vsplit<CR>",             desc = "Vertical split window" },
    -- Buffer mappings
    { "<A-c>",      "<cmd>bd!<CR>",                                   desc = "Close current buffer" },
    { "<A-1>",      "<cmd>BufferLineGoToBuffer 1<CR>",                desc = "Change buffer" },
    { "<A-2>",      "<cmd>BufferLineGoToBuffer 2<CR>",                desc = "Change buffer" },
    { "<A-3>",      "<cmd>BufferLineGoToBuffer 3<CR>",                desc = "Change buffer" },
    { "<A-4>",      "<cmd>BufferLineGoToBuffer 4<CR>",                desc = "Change buffer" },
    { "<A-5>",      "<cmd>BufferLineGoToBuffer 5<CR>",                desc = "Change buffer" },
    { "<A-6>",      "<cmd>BufferLineGoToBuffer 6<CR>",                desc = "Change buffer" },
    { "<A-7>",      "<cmd>BufferLineGoToBuffer 7<CR>",                desc = "Change buffer" },
    { "<A-8>",      "<cmd>BufferLineGoToBuffer 8<CR>",                desc = "Change buffer" },
    { "<A-9>",      "<cmd>BufferLineGoToBuffer 9<CR>",                desc = "Change buffer" },
    { "<A-0>",      "<cmd>BufferLineGoToBuffer -1<CR>",               desc = "Change buffer" },
    { "<A-{>",      "<cmd>BufferLineMovePrev<CR>",                    desc = "Change places with the previous buffer" },
    { "<A-}>",      "<cmd>BufferLineMoveNext<CR>",                    desc = "Change places with the next buffer" },
    { "<A-,>",      "<cmd>BufferLineCyclePrev<CR>",                   desc = "Navigate to the previous buffer" },
    { "<A-.>",      "<cmd>BufferLineCycleNext<CR>",                   desc = "Navigate to the next buffer" },
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
    -- Terminal on Neovim
    { "<A-t>",     desc = "Open a Terminal" },
    -- Debug adapter mappings
    { "<leader>d", group = "DAP (Debug Adapter Protocol)" },
    {
      "<leader>db",
      "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
      desc = "Toggle breakpoint",
      group = "Debug Adapter",
    },
    {
      "<leader>dB",
      "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
      desc = "Set breakpoint with a condition to stop",
      group = "Debug Adapter",
    },
    {
      "<leader>dlp",
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end,
      desc = "Breakpoint with log message",
    },
    {
      "<leader>dr",
      function()
        require("dap").repl.open()
      end,
      desc = "Open repl",
    },
    {
      "<leader>dlr",
      function()
        require("dap").run.last()
      end,
      desc = "Run last",
    },
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Run/Continue from breakpoint",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "Step over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "Step into",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "Step out",
    },
    { "<leader>p",   group = "Python" },
    { "<leader>pm",  "<cmd>lua require('dap-python´).test_method()<CR>", desc = "Test method" },
    { "<leader>pc",  "<cmd>lua require('dap-python´).test_class()<CR>",  desc = "Test class" },
    -- Twilight
    { "<leader>l",   "<cmd>Twilight<CR>",                                desc = "Focus on spec with treesitter" },
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
    { ":",           "<cmd>Telescope cmdline<CR>",                       desc = "Run cmdline with Telescope" },
    -- Gitsigns
    { "<leader>h",   group = "Gitsigns" },
    { "<leader>hb",  desc = "Gitsigns preview blame line" },
    { "<leader>hc",  desc = "Gitsigns toggle current blame line" },
    { "<leader>hd",  desc = "Gitsigns show diffs" },
    { "<leader>hD",  desc = "Gitsigns show other diffs" },
    { "<leader>he",  desc = "Gitsigns toggle deleted lines" },
    { "<leader>hp",  desc = "Gitsigns preview hunk" },
    { "<leader>hs",  desc = "Gitsigns stage hunk" },
    { "<leader>hS",  desc = "Gitsigns stage buffer" },
    { "<leader>hr",  desc = "Gitsigns reset hunk" },
    { "<leader>hR",  desc = "Gitsigns reset buffer" },
    { "<leader>hu",  desc = "Gitsigns undo stage hunk" },
    { "{g",          desc = "Gitsigns navigation: previous" },
    { "}g",          desc = "Gitsigns navigation: next" },
    -- Glow
    { "<leader>g",   "<cmd>Glow<CR>",                                    desc = "Preview current md file" },
  },
  {
    -- Jdtls
    mode = { "v" },
    { "<leader>j",  group = "Jdtls" },
    { "<leader>jc", desc = "Extract constant" },
    { "<leader>jm", desc = "Extract method" },
    { "<leader>jv", desc = "Extract variable" },
    -- DAP
    { "<leader>d",  group = "DAP" },
    { "<leader>ds", "<Esc><cmd>lua require('dap-python').debug_selection()<CR>", desc = "Test selection" },
  },
})
