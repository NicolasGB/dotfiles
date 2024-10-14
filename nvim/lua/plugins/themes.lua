return {
  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup {
        background = "hard",
        float_style = "dim",
        on_highlights = function(hl, _)
          hl.LspInlayHint = { fg = "#6C7E8C", bold = true, ctermfg = 198, cterm = { bold = true } }
        end,
      }

      vim.cmd.colorscheme "everforest"
    end,
    lazy = false,
    priority = 1000,
  },
}
