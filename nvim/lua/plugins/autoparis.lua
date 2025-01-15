return {
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recommended as each new version will have breaking changes
    config = function()
      require("ultimate-autopair").init {
        require("ultimate-autopair").extend_default {
          extensions = {
            -- Disable in telescope and snacks picker input
            filetype = { nft = { "TelescopePrompt", "snacks_picker_input" } },
          },
          fastwarp = {
            multi = true,
            { faster = true, map = "<A-e>", cmap = "<A-e>" },
          },
        },
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
