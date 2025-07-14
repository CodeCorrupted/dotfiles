local on_attach = function(bufnr)
  local gitsigns = require("gitsigns")
  local wk = require("which-key")

  wk.add({
    {
      mode = { "n" },
      {
        "}c",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "}c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end,
        desc = "Git navigation: next"
      },
      {
        "{c",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "{c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end,
        desc = "Git navigation: previous"
      },
      { "<leader>h", group = "GitSigns" },
      { "<leader>hs", gitsigns.stage_hunk, desc = "Stage the hunk at the cursor position" },
      { "<leader>hr", gitsigns.reset_hunk, desc = "Reset the lines of the hunk at the cursor position" },
      { "<leader>hS", gitsigns.stage_buffer, desc = "Stage all hunks in current buffer" },
      { "<leader>hu", gitsigns.undo_stage_hunk, desc = "Undo the last call of stage_hunk (not buffer)" },
      { "<leader>hR", gitsigns.reset_buffer, desc = "Reset the lines of all hunks in the buffer" },
      { "<leader>hp", gitsigns.preview_hunk, desc = "Preview the hunk at the cursor position" },
      { "<leader>hb", function ()
        gitsigns.blame_line({ full = true })
      end, desc = "Run git blame on the current line and show the results" },
      {"<leader>hc", gitsigns.toggle_current_line_blame, desc = "Toggle gitsigns-config-current_line_blame"},
      {"<leader>hd", gitsigns.diffthis, desc = "Perform a vimdiff of this file"},
      {"<leader>hD", function()
        gitsigns.diffthis("~")
      end, desc = "Perform a vimdiff of this file with its last commit"},
      { "<leader>he", gitsigns.toggle_deleted, desc = "Toggle gitsigns-config-show_deleted" },
      {},
    },
    {
      mode = {"v"},
      { "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, desc = "Stage the hunk of the selected lines"},
      { "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, desc = "Reset the selected lines of the hunk"},
    },
    {
      mode = {"o", "x"},
      {"ih", ":<C-u>Gitsigns select_hunk<CR>"},
    },
  }, { buffer = bufnr })
end

require("gitsigns").setup({
  on_attach = on_attach,
})
