return {
  {
    "iamcco/markdown-preview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- Replace this with && if on bash
    build = "cd app; yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 0
    end,
    ft = { "markdown" },
    config = function()
      vim.keymap.set("n", "<leader>md", vim.cmd.MarkdownPreview, { desc = "Markdown preview" })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    config = function()
      require("render-markdown").setup {
        file_types = {
          "codecompanion",
          "rust",
        },
        heading = {
          enabled = false,
        },
      }
    end,
  },
  -- {
  --   -- init.lua
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = function()
  --     require("headlines").setup {
  --       markdown = {
  --         headline_highlights = false,
  --       },
  --     }
  --   end,
  -- },
}
