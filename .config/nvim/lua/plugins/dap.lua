local dap = require("dap")
local mason_path = vim.fn.stdpath('data') .. "/mason"

-- Debug adapter for Python
require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

-- Bashdb dap
dap.adapters.bashdb = {
  type = "executable",
  command = mason_path .. "/packages/bash-debug-adapter/bash-debug-adapter",
  name = "bashdb",
}

dap.configurations.sh = {
  {
    type = "bashdb",
    request = "launch",
    name = "Launch file",
    showDebugOutput = true,
    pathBashdb = mason_path .. "/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
    pathBashdbLib = mason_path .. "/packages/bash-debug-adapter/extension/bashdb_dir",
    trace = true,
    file = "${file}",
    program = "${file}",
    cwd = "${workspaceFolder}",
    pathCat = "cat",
    pathBash = "/bin/bash",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    args = {},
    argsString = "",
    env = {},
    terminalKind = "integrated",
  },
}

-- Java dap
dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = 'Debug (Attach) - Remote',
    hostName = '127.0.0.1',
    port = 5005,
  },
}

-- JS dap
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { mason_path .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
  }
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    skipFiles = { '<node_internals>/**' }
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to Node Process",
    processId = require('dap.utils').pick_process,
    cwd = "${workspaceFolder}",
    skipFiles = { "<node_internals>/**" }
  },
  {
    type = "pwa-chrome",
    request = "launch",
    name = "Launch Chrome",
    url = "http://localhost:3000",
    webRoot = "${workspaceFolder}",
    sourceMaps = true,
    userDataDir = false
  }
}

-- Extend JS config to TS and React
dap.configurations.typescript = dap.configurations.javascript
dap.configurations.javascriptreact = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.javascript

-- Icons for DAP
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })

-- Add mappings to supported filetypes
vim.api.nvim_create_augroup("DAPMappings", { clear = true })

-- Function to verify if the actual buffer has DAP configurations
local function has_dap_config()
  local ft = vim.bo.filetype
  return ft and dap.configurations[ft] ~= nil
end

-- Function to define mappings
local function setup_dap_mappings(buf)
  local wk = require("which-key")
  wk.add({
    {
      mode = { "n" },
      {
        "<F5>",
        function()
          dap.continue()
        end,
        desc = "Run/Continue from breakpoint"
      },
      { "<F10>", function()
        dap.step_over()
      end, desc = "DAP: Step Over" },
      { "<F11>", function()
        dap.step_into()
      end, desc = "DAP: Step Into" },
      { "<F12>", function()
        dap.step_out()
      end, desc = "DAP: Step Out" },
      { "<leader>d", group = "DAP Mappings" },
      { "<leader>db", function ()
        dap.toggle_breakpoint()
      end, desc = "Toggle breakpoint" },
      { "<leader>dB", function ()
        dap.toggle_breakpoint(vim.fn.input("Breakpoint Condition: "))
      end, desc = "Conditional breakpoint" },
      { "<leader>dlp", function ()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, desc = "Breakpoint with log message" },
      { "<leader>dr", function ()
        dap.repl.open()
      end, desc = "Open repl" },
      { "<leader>dlr", function ()
        dap.run_last()
      end, desc = "Open repl" },
    },
  }, { buffer = buf })
  if vim.bo[buf].filetype == "python" then
    wk.add({
      {
        mode = {"n"},
        {"<leader>dn", function()
          require("dap-python").test_method()
        end, desc = "Test Method"},
        {"<leader>df", function()
          require("dap-python").test_class()
        end, desc = "Test Class"},
      },
      {
        mode = {"v"},
        {"<leader>ds", function()
          require("dap-python").debug_selection()
        end, desc = "Debug Selection"}
      }
    })
  end
end

-- Apply mappings
vim.api.nvim_create_autocmd("BufEnter", {
  group = "DAPMappings",
  callback = function(args)
    if has_dap_config() then
      setup_dap_mappings(args.buf)
    end
  end
})

-- Clean mappings when exitting from compatible buffers
vim.api.nvim_create_autocmd("BufLeave", {
  group = "DAPMappings",
  callback = function(args)
    if has_dap_config() then
      local mappings = { "<F5>", "<F10>", "<F11>", "<F12>", "<leader>db", "<leader>dB", "<leader>dn", "<leader>df",
        "<leader>ds" }
      for _, key in ipairs(mappings) do
        pcall(vim.keymap.del, "n", key, { buffer = args.buf })
        pcall(vim.keymap.del, "v", key, { buffer = args.buf })
      end
    end
  end
})
