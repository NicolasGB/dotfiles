return {
  {
    "iamcco/markdown-preview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 0
      -- Use the system default browser: `open` on macOS, `xdg-open` on Linux.
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 1
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
