return {
  {
    "romgrk/barbar.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    branch = "master",
    config = function()
      require("barbar").setup {
        icons = {
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
            [vim.diagnostic.severity.WARN] = { enabled = false },
            [vim.diagnostic.severity.INFO] = { enabled = false },
            [vim.diagnostic.severity.HINT] = { enabled = true },
          },
          gitsigns = {
            added = { enabled = true, icon = "+" },
            changed = { enabled = true, icon = "~" },
            deleted = { enabled = true, icon = "-" },
          },
        },
      }

      --Keymaps
      vim.keymap.set("n", "<A-,>", vim.cmd.BufferPrevious)
      vim.keymap.set("n", "<A-.>", vim.cmd.BufferNext)

      vim.keymap.set("n", "<A-c>", vim.cmd.BufferClose)

      vim.keymap.set("n", "<leader>bc", vim.cmd.BufferCloseAllButCurrent)
    end,
  },
}
