return {
  {
    dir = "~/dev/personal/plugins/jj.nvim",
    name = "jj.nvim",
    config = function()
      local jj = require "jj"
      jj.setup {}

      local cmd = require "jj.cmd"
      vim.keymap.set("n", "<leader>jd", cmd.describe, { desc = "JJ describe" })
      vim.keymap.set("n", "<leader>jl", cmd.log, { desc = "JJ log" })
      vim.keymap.set("n", "<leader>je", cmd.edit, { desc = "JJ edit" })
      -- vim.keymap.set("n", "<leader>jl", function()
      --   cmd.log {
      --     revisions = "all()",
      --   }
      -- end, { desc = "JJ log" })
      vim.keymap.set("n", "<leader>jn", cmd.new, { desc = "JJ new" })
      vim.keymap.set("n", "<leader>js", cmd.status, { desc = "JJ status" })
      vim.keymap.set("n", "<leader>dj", cmd.diff, { desc = "JJ diff" })
      vim.keymap.set("n", "<leader>sj", cmd.squash, { desc = "JJ squash" })
    end,
  },
  -- {
  --   "nicolasgb/jj.nvim",
  --   config = function()
  --     local jj = require "jj"
  --     jj.setup {}
  --
  --     local cmd = require "jj.cmd"
  --     vim.keymap.set("n", "<leader>jd", cmd.describe, { desc = "JJ describe" })
  --     vim.keymap.set("n", "<leader>jl", cmd.log, { desc = "JJ log" })
  --     vim.keymap.set("n", "<leader>je", cmd.edit, { desc = "JJ edit" })
  --     -- vim.keymap.set("n", "<leader>jl", function()
  --     --   cmd.log {
  --     --     revisions = "all()",
  --     --   }
  --     -- end, { desc = "JJ log" })
  --     vim.keymap.set("n", "<leader>jn", cmd.new, { desc = "JJ new" })
  --     vim.keymap.set("n", "<leader>js", cmd.status, { desc = "JJ status" })
  --     vim.keymap.set("n", "<leader>dj", cmd.diff, { desc = "JJ diff" })
  --     vim.keymap.set("n", "<leader>sj", cmd.squash, { desc = "JJ squash" })
  --   end,
  -- },
}
