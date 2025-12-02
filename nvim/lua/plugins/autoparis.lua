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
          -- fastwarp = {
          --   multi = true,
          --   { faster = true, map = "<A-e>", cmap = "<A-e>" },
          -- },
        },
      }
    end,
  },
  {
    "xzbdmw/clasp.nvim",
    config = function()
      require("clasp").setup {
        pairs = { ["{"] = "}", ['"'] = '"', ["'"] = "'", ["("] = ")", ["["] = "]", ["<"] = ">" },
        -- If called from insert mode, do not return to normal mode.
        keep_insert_mode = true,
        -- consider the following go code:
        --
        -- `var s make()[]int`
        --
        -- if we want to turn it into:
        --
        -- `var s make([]int)`
        --
        -- Directly parse would produce wrong nodes, so clasp always removes the
        -- entire pair (`()` in this case) before parsing, in this case what the
        -- parser would see is `var s make[]int`, but this is still not valid
        -- grammar. For a better parse tree, we can aggressively remove all
        -- alphabetic chars before cursor, so it becomes:
        --
        -- `var s []int`
        --
        -- Now we can correctly wrap the entire `[]int`, because it is identified
        -- as a node. By default we only remove current pair(s) before parsing, in
        -- most cases this is fine, but you can set `remove_pattern = "[a-zA-Z_%-]+$"`
        -- to use a more aggressive approach if you run into problems.
        remove_pattern = nil,
      }
      vim.keymap.set({ "n", "i" }, "<A-e>", function()
        require("clasp").wrap "next"
      end)
      vim.keymap.set({ "n", "i" }, "<A-w>", function()
        require("clasp").wrap "prev"
      end)
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
