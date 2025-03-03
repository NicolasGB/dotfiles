return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup {
        tag_options = "",
        trouble = true,
        -- Not managed here
        diagnostic = false,
        lsp_document_formatting = false,
        lsp_inlay_hints = nil,
      }
    end,
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  -- {
  --   "fatih/vim-go",
  --   ft = { "go", "gomod" },
  --   config = function()
  --     --Disable colliding binding
  --     vim.g.go_def_mapping_enabled = 0
  --     --Use gopls in fillstruct
  --     vim.g.go_fillstruct_mode = "gopls"
  --   end,
  -- },
}
