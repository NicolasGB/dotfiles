return {
  "Wansmer/treesj",
  keys = {
    {
      "<leader>cj",
      function()
        require("treesj").toggle()
      end,
    },
    {
      "gJ",
      function()
        require("treesj").join()
      end,
    },
    {
      "gS",
      function()
        require("treesj").split()
      end,
    },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup {}
  end,
}
