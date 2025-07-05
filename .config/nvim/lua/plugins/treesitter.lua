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
