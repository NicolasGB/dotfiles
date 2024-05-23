return {
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 200 },
    lazy = false,
    config = function()
      require("illuminate").configure {}
    end,
  },
}
