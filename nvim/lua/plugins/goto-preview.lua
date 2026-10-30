-- Peek LSP definitions/implementations in floating windows
return {
  "rmagatti/goto-preview",
  event = "LspAttach",
  config = function()
    local gp = require "goto-preview"
    gp.setup {
      border = "rounded",
      default_mappings = false,
    }

    -- Close all previews when focus goes back to a normal (non-floating) window.
    -- Moving between stacked previews keeps them open.
    vim.api.nvim_create_autocmd("WinEnter", {
      group = vim.api.nvim_create_augroup("GotoPreviewAutoClose", { clear = true }),
      callback = function()
        if vim.api.nvim_win_get_config(0).relative == "" then
          gp.close_all_win()
        end
      end,
    })
  end,
  keys = {
    { "<leader>vf", function() require("goto-preview").goto_preview_definition() end, desc = "Peek definition" },
    { "<leader>vi", function() require("goto-preview").goto_preview_implementation() end, desc = "Peek implementation" },
    { "<leader>vF", function() require("goto-preview").close_all_win() end, desc = "Close all peek windows" },
  },
}
