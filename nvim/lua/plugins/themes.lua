return {
  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup {
        background = "hard",
        float_style = "dim",
      }

      vim.cmd.colorscheme "everforest"
    end,
    lazy = false,
    priority = 1000,
  },
}
