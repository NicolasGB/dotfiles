return {
  {
    "nvim-neorg/neorg",
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
