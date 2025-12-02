return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require "oil"
      oil.setup {
        default_file_explorer = false, -- If i get used to might activate it later
        keymaps = {
          ["<C-s>"] = vim.cmd.w,
          ["q"] = "actions.close",
          ["<A-u>"] = "actions.parent",
          ["<C-h>"] = "actions.select_vsplit",
        },
        view_options = {
          show_hidden = true,
        },
        float = {
          border = "rounded",
          max_width = 100,
          max_height = 50,
        },
      }
      vim.keymap.set("n", "<leader>pv", oil.open_float, { desc = "Open parent directory" })
    end,
  },
}
