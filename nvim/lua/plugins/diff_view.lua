return {
  {
    "sindrets/diffview.nvim",
  },
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    opts = {
      keymaps = {
        view = {
          next_hunk = "<C-j>",
          prev_hunk = "<C-k>",
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
