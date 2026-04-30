return {
  "ThePrimeagen/refactoring.nvim",
  event = "VeryLazy",
  dependencies = {
    "lewis6991/async.nvim",
  },
  config = function()
    require("refactoring").setup {
      prompt_func_return_type = {
        go = true,
      },
      prompt_func_param_type = {
        go = true,
      },
    }

    vim.keymap.set("x", "<leader>rr", function()
      require("refactoring").select_refactor()
    end, { desc = "Select refactor" })
  end,
}
