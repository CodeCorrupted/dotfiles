require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/debugpy")
-- If you need to use the debugpy outside of Mason
-- require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
local dap = require("dap")

--Call :lua require('dap').continue() to start debugging.
-- See :help dap-mappings and :help dap-api.
-- Use :lua require('dap-python').test_method() to debug the closest method above the cursor.

-- Bashdb dap
dap.adapters.bashdb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
	name = "bashdb",
}

dap.configurations.sh = {
	{
		type = "bashdb",
		request = "launch",
		name = "Launch file",
		showDebugOutput = true,
		pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
		pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
		trace = true,
		file = "${file}",
		program = "${file}",
		cwd = "${workspaceFolder}",
		pathCat = "cat",
		pathBash = "/bin/bash",
		pathMkfifo = "mkfifo",
		pathPkill = "pkill",
		args = {},
		env = {},
		terminalKind = "integrated",
	},
}

dap.configurations.java = {
	{
		type = "java",
		request = "attach",
		name = "Debug (Attach) - Remote",
		hostName = "127.0.0.1",
		port = 5005,
	},
}

local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Notifications proportioned by notify-nvim
-- Utility functions shared between progress reports for LSP and DAP

local client_notifs = {}

local function get_notif_data(client_id, token)
	if not client_notifs[client_id] then
		client_notifs[client_id] = {}
	end

	if not client_notifs[client_id][token] then
		client_notifs[client_id][token] = {}
	end

	return client_notifs[client_id][token]
end

local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

local function update_spinner(client_id, token)
	local notif_data = get_notif_data(client_id, token)

	if notif_data.spinner then
		local new_spinner = (notif_data.spinner + 1) % #spinner_frames
		notif_data.spinner = new_spinner

		notif_data.notification = vim.notify(nil, nil, {
			hide_from_history = true,
			icon = spinner_frames[new_spinner],
			replace = notif_data.notification,
		})

		vim.defer_fn(function()
			update_spinner(client_id, token)
		end, 100)
	end
end

local function format_title(title, client_name)
	return client_name .. (#title > 0 and ": " .. title or "")
end

local function format_message(message, percentage)
	return (percentage and percentage .. "%\t" or "") .. (message or "")
end

-- DAP integration
-- Make sure to also have the snippet with the common helper functions in your config!

dap.listeners.before["event_progressStart"]["progress-notifications"] = function(session, body)
	local notif_data = get_notif_data("dap", body.progressId)

	local message = format_message(body.message, body.percentage)
	notif_data.notification = vim.notify(message, "info", {
		title = format_title(body.title, session.config.type),
		icon = spinner_frames[1],
		timeout = false,
		hide_from_history = false,
	})

	notif_data.notification.spinner = 1, update_spinner("dap", body.progressId)
end

dap.listeners.before["event_progressUpdate"]["progress-notifications"] = function(session, body)
	local notif_data = get_notif_data("dap", body.progressId)
	notif_data.notification = vim.notify(format_message(body.message, body.percentage), "info", {
		replace = notif_data.notification,
		hide_from_history = false,
	})
end

dap.listeners.before["event_progressEnd"]["progress-notifications"] = function(session, body)
	local notif_data = client_notifs["dap"][body.progressId]
	notif_data.notification = vim.notify(body.message and format_message(body.message) or "Complete", "info", {
		icon = "",
		replace = notif_data.notification,
		timeout = 3000,
	})
	notif_data.spinner = nil
end
