return {
  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup {
        background = "hard",
        -- diagnostic_text_highlight = true,
        float_style = "dim",
        -- dim_inactive_windows = true,
      }

      vim.cmd.colorscheme "everforest"
    end,
    lazy = false,
    priority = 1,
  },
}
