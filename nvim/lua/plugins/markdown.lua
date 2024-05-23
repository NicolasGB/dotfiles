return {
  {
    "iamcco/markdown-preview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = function()
      local install_path = vim.fn.stdpath "data" .. "/lazy/markdown-preview.nvim/app"
      vim.cmd("silent !cd " .. install_path .. " && npm install && git restore .")
    end,
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
    -- init.lua
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("headlines").setup {
        markdown = {
          headline_highlights = false,
        },
      }
    end,
  },
}
