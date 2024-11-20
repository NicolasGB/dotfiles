return {
  {
    "nvim-neorg/neorg",
    event = "VeryLazy",
    dependencies = {
      "nvim-neorg/lua-utils.nvim",
      "pysan3/pathlib.nvim",
    },
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {}, -- We added this line!
        },
      }
    end,
  },
}
