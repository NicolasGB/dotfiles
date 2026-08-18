return {
  {
    "sindrets/diffview.nvim",
  },
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    opts = {
      diff = {
        jump_to_first_change = false,
      },
      keymaps = {
        view = {
          next_hunk = "<C-n>",
          prev_hunk = "<C-p>",
        },
      },
    },
  },
  "clabby/difftastic.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("difftastic-nvim").setup {
      download = true, -- Auto-download pre-built binary
    }
  end,
}
