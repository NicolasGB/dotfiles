return {
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6", --recommended as each new version will have breaking changes
    opts = {
      fastwarp = {
        multi = true,
        {},
        { faster = true, map = "<A-e>", cmap = "<A-e>" },
      },
    },
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
