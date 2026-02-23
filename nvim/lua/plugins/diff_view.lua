return {
  {
    "sindrets/diffview.nvim",
  },
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
  },
  "clabby/difftastic.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("difftastic-nvim").setup {
      download = true, -- Auto-download pre-built binary
    }
  end,
}
