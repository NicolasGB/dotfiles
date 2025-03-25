return {
  {
    "neanias/everforest-nvim",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("everforest").setup {
        background = "hard",
        transparent_background_level = 2,
        -- sign_column_background = "grey",
        -- ui_contrast = "high",
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
