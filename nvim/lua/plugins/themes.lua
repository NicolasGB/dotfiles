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
          -- Orange code comments across languages; keep documentation and UI grey.
          hl["@comment"] = { fg = "#F5A044", italic = true }
          hl["@comment.documentation"] = { link = "Comment" }
          hl["@comment.jjdescription"] = { link = "Comment" }
        end,
      }

      vim.cmd.colorscheme "everforest"
    end,
    lazy = false,
    priority = 1000,
  },
}
