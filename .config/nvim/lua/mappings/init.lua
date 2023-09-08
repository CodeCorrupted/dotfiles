-- Scan if which_key is installed
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end
-- opts for mappings
local opts = {
	mode = "n", -- NORMAL mode
	prefix = "",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["<leader>"] = {
		t = {
			name = "Telescope",
			f = { "<cmd>Telescope find_files<CR>", "Find file" },
			l = { "<cmd>Telescope live_grep<CR>", "Search with live_grep" },
			m = { "<cmd>Telescope media_files<CR>", "Find images" },
			n = { "<cmd>Telescope notify<CR>", "Find messages" },
			p = { "<cmd>Telescope neoclip<CR>", "Find yanked/deleted text" },
			d = {
				name = "DAP",
				m = { "<cmd>Telescope dap commands<CR>", "Show commands on dap" },
				c = { "<cmd>Telescope dap configurations<CR>", "Show configurations for dap" },
				l = { "<cmd>Telescope dap list_breakpoints<CR>", "Show a list of breakpoints" },
				v = { "<cmd>Telescope dap variables<CR>", "Show the variables on dap" },
				f = { "<cmd>Telescope dap frames<CR>", "Show frames on dap" },
			},
		},
		s = {
			name = "Split",
			h = { "<cmd>split<CR>", "Horizontal split" },
			v = { "<cmd>vsplit<CR>", "Vertical split" },
		},
		w = { "<cmd>Twilight<CR>", "Focus the function with treesitter" },
		d = {
			name = "Debugger",
			b = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint" },
			B = {
				"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
				"Set breakpoint with a condition to stop",
			},
			p = {
				"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
				"Set a logpoint",
			},
			r = { "<cmd>lua require'dap'.repl.open()<CR>", "Open REPL/Debug console" },
			l = { "<cmd>lua require'dap'.run_last()<CR>", "Re-runs the last debug adapter" },
			k = {
				"<cmd>lua require'dapui'.eval()<CR>",
				"Open a floating window containing the result of evaluting an expression",
			},
			j = { "<cmd>JdtUpdateDebugConfig<CR>", "Update the configurations for debug Java" },
		},
		n = {
			name = "NvimTree",
			t = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },
		},
		g = { "<cmd>Glow<CR>", "Open previewer of .md files" },
	},
	["tn"] = { "<cmd>tabnext<CR>", "Go to next tab" },
	["tp"] = { "<cmd>tabprevious<CR>", "Go to previous tab" },
	["<C-Up>"] = { "<cmd>resize +2<CR>", "Add 2pts to horizontal window" },
	["<C-Down>"] = { "<cmd>resize -2<CR>", "Substract 2pts to horizontal window" },
	["<C-Left>"] = { "<cmd>vertical resize +2<CR>", "Add 2pts to vertical window" },
	["<C-Right>"] = { "<cmd>vertical resize -2<CR>", "Substract 2pts to vertical window" },
	["<C-c>"] = { "<cmd>lua ChangeColorScheme()<CR>", "Change the colorscheme" },
	["<A-h>"] = { "<C-w>h", "Go to vertical window at the left" },
	["<A-j>"] = { "<C-w>j", "Go to horizontal window at the bottom" },
	["<A-k>"] = { "<C-w>k", "Go to horizontal window at the top" },
	["<A-l>"] = { "<C-w>l", "Go to vertical window at the left" },
	["<A-1>"] = { "<cmd>BufferLineGoToBuffer 1<CR>", "Change to buffer" },
	["<A-2>"] = { "<cmd>BufferLineGoToBuffer 2<CR>", "Change to buffer" },
	["<A-3>"] = { "<cmd>BufferLineGoToBuffer 3<CR>", "Change to buffer" },
	["<A-4>"] = { "<cmd>BufferLineGoToBuffer 4<CR>", "Change to buffer" },
	["<A-5>"] = { "<cmd>BufferLineGoToBuffer 5<CR>", "Change to buffer" },
	["<A-6>"] = { "<cmd>BufferLineGoToBuffer 6<CR>", "Change to buffer" },
	["<A-7>"] = { "<cmd>BufferLineGoToBuffer 7<CR>", "Change to buffer" },
	["<A-8>"] = { "<cmd>BufferLineGoToBuffer 8<CR>", "Change to buffer" },
	["<A-9>"] = { "<cmd>BufferLineGoToBuffer 9<CR>", "Change to buffer" },
	["<A-0>"] = { "<cmd>BufferLineGoToBuffer -1<CR>", "Change to buffer" },
	["<A-{>"] = { "<cmd>BufferLineMovePrev<CR>", "Move at previous buffer" },
	["<A-}>"] = { "<cmd>BufferLineMoveNext<CR>", "Move at next buffer" },
	["<A-.>"] = { "<cmd>BufferLineCycleNext<CR>", "Switch places with the next buffer" },
	["<A-,>"] = { "<cmd>BufferLineCyclePrev<CR>", "Switch places with the previous buffer" },
	["<A-c>"] = { "<cmd>bdelete!<CR>", "Close current buffer" },
	["<F2>"] = { "<cmd>w!<CR>", "Save" },
	["<F3>"] = { "<cmd>q!<CR>", "Quit" },
	["<F4>"] = { "<cmd>lua require'dap'.continue()<CR>", "Launch debugger on next breakpoint" },
	["<F5>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Jump to the next line" },
	["<F6>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Jump into the called function" },
	["<F7>"] = { "<cmd>lua require'dap'.step_out()<CR>", "Exit from the function jumped into" },
}

which_key.register(mappings, opts)
