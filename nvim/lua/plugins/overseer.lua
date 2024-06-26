return {
  {
    "stevearc/overseer.nvim",
    opts = {
      -- template_cache_threshold = 0,
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
      { "<leader>rl", "<cmd>OverseerRestartLast<CR>", desc = "Open overseer tasks" },
    },
    init = function()
      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local overseer = require "overseer"
        local tasks = overseer.list_tasks { recent_first = true }
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    end,
  },
}
