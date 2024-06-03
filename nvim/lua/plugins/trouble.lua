return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {
        focus = true,
      }
      vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>")
      vim.keymap.set("n", "<leader>qf", "<cmd>Trouble qflist toggle<cr")

      --- Trouble signs
    end,
  },
}
