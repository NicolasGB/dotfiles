return {
  -- {
  --   "altermo/ultimate-autopair.nvim",
  --   event = { "InsertEnter", "CmdlineEnter" },
  --   branch = "v0.6", --recommended as each new version will have breaking changes
  --   config = function()
  --     require("ultimate-autopair").init {
  --       require("ultimate-autopair").extend_default {
  --         extensions = {
  --           -- Disable in telescope and snacks picker input
  --           filetype = { nft = { "TelescopePrompt", "snacks_picker_input" } },
  --         },
  --         -- fastwarp = {
  --         --   multi = true,
  --         --   { faster = true, map = "<A-e>", cmap = "<A-e>" },
  --         -- },
  --       },
  --     }
  --   end,
  -- },
  {
    "saghen/blink.pairs",
    version = "*", -- (recommended) only required with prebuilt binaries
    dependencies = "saghen/blink.download",

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        enabled = true,
        cmdline = true,
        -- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
        -- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
        disabled_filetypes = {},
        -- see the defaults:
        -- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L14
        pairs = {},
      },
      highlights = {
        enabled = true,
        -- requires require('vim._extui').enable({}), otherwise has no effect
        cmdline = true,
        groups = {
          -- "BlinkPairsOrange",
          -- "BlinkPairsPurple",
          -- "BlinkPairsBlue",
        },
        unmatched_group = "BlinkPairsUnmatched",

        -- highlights matching pairs under the cursor
        matchparen = {
          enabled = true,
          -- known issue where typing won't update matchparen highlight, disabled by default
          cmdline = false,
          -- also include pairs not on top of the cursor, but surrounding the cursor
          include_surrounding = false,
          group = "BlinkPairsMatchParen",
          priority = 250,
        },
      },
      debug = false,
    },
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
      -- vim.keymap.set({ "n", "i" }, "<A-w>", function()
      --   require("clasp").wrap "prev"
      -- end)
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
      }
    end,
  },
}
