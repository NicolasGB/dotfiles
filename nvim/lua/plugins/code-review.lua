return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup {
        use_local_fs = true,
        default_merge_method = "squash",
        default_delete_branch = true,
        -- picker = "snacks",
        ssh_aliases = { ["te.github.com"] = "github.com" },
        default_to_projects_v2 = true,
      }

      -- Add treesitter markdown highlighting
      vim.treesitter.language.register("markdown", "octo")
    end,
  },
}
