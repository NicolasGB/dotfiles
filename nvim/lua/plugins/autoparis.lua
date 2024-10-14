return {
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recommended as each new version will have breaking changes
    config = function()
      require("ultimate-autopair").init {
        require("ultimate-autopair").extend_default {
          fastwarp = {
            multi = true,
            { faster = true, map = "<A-e>", cmap = "<A-e>" },
          },
          { "<", ">", fly = true, dosuround = true, multiline = false, space = true, surround = true },
        },
        { profile = require("ultimate-autopair.experimental.cmpair").init },
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup {
        autotag = {
          enable = true,
        },
      }
    end,
  },
}
