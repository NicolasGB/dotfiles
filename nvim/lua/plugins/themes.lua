return {
  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup {
        background = "hard",
        float_style = "dim",
      }

      -- local hour = tonumber(os.date "%H")
      -- if hour >= 7 and hour < 12 then
      --   vim.o.background = "light"
      -- else
      --   vim.o.background = "dark"
      -- end

      vim.cmd.colorscheme "everforest"
    end,
    lazy = false,
    priority = 1000,
  },
}
