require("dapui").setup({
  icons = { expanded = "▾" , collapsed =  "▸", current_frame = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>", "zo" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
    close = "q",
    inspect = "i",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
  },
  force_buffers = true,
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = true,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.30 },
        { id = "breakpoints", size = 0.15 },
        { id = "stacks", size = 0.15 },
        { id = "watches", size = 0.40 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 45, -- 45 columns
      position = "left",
    },
    {
      elements = {
        { id = "repl", size = 0.75 },
        { id = "console", size = 0.25 },
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = 0.7, -- These can be integers or a float between 0 and 1.
    max_width = 0.7, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
      expand = "e",
      inspect = "<Tab>",
    },
  },
  windows = {
    indent = 1,
    max_type_length = 50,
    max_value_lines = 20,
    show_header = true,
    highlight_changed = true,
    value_formatter = function (value, context)
      if type(value) == "string" then
        return '"' .. value:sub(1, 100) .. (string.len(value) > 100 and "..." or "") .. '"'
      end
      return value
    end
  },
  auto_open = true,
  auto_close = true,
  preserve_windows = true,
  update_in_insert = false,
  render = {
    indent = 1,
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  },
  repl = {
    height = 15,
    hide_on_continue = false,
    command_shortcuts = {
      clear = "<C-l>",
      history_up = "<Up>",
      history_down = "<Down>",
    },
  },
})
