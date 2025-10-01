return {
  {
    dir = "~/dev/personal/plugins/jj.nvim",
    -- dir = "~/dev/personal/plugins/jj-pr",
    name = "jj.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
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
      vim.keymap.set("n", "<leader>dcj", function()
        cmd.diff { current = true }
      end, { desc = "JJ diff current" })

      vim.keymap.set("n", "<leader>sj", cmd.squash, { desc = "JJ squash" })
      -- Uplift the bookmark
      vim.keymap.set("n", "<leader>jt", function()
        cmd.j "tug"
      end, { desc = "JJ tug" })
      -- Push and pull
      vim.keymap.set("n", "<leader>jp", function()
        cmd.j "pull"
      end, { desc = "JJ pull" })
      vim.keymap.set("n", "<leader>jP", function()
        cmd.j "push"
      end, { desc = "JJ push" })

      vim.keymap.set("n", "<leader>gj", function()
        require("jj.picker").status()
      end, { desc = "JJ Picker status" })
      vim.keymap.set("n", "<leader>jgh", function()
        require("jj.picker").file_history()
      end, { desc = "JJ Picker history" })
    end,
  },
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    config = function()
      require("hunk").setup()
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
