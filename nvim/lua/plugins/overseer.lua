return {
  {
    "stevearc/overseer.nvim",
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
      strategy = {
        "toggleterm",
      },
    },
    keys = {
      { "<leader>rt", "<cmd>OverseerRun<CR>", desc = "Open overseer tasks" },
      {
        "<leader>ot",
        function()
          require("overseer").toggle()
        end,
        desc = "Toggle overseer",
      },
    },
  },
}
