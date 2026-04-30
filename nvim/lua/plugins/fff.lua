return {
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    lazy = false,
    -- commit = "eb577ea4f39f7b9296ff8c6b4bf2b2899d017ded",
    keys = {
      {
        "<leader><space>", -- try it if you didn't it is a banger keybinding for a picker
        function()
          require("fff").find_files {}
        end,
        desc = "FFFind files",
      },
      {
        "<leader>gr",
        function()
          require("fff").live_grep {
            grep = {
              modes = { "fuzzy", "plain" },
            },
          }
        end,
        desc = "FFF live grep",
      },
    },
    config = function()
      require("fff").setup {
        title = "Files",
        prompt = " ",
        layout = {
          prompt_position = "top",
        },
        preview = {
          line_numbers = true,
        },
        keymaps = {
          move_down = { "<C-j>", "<Down>" },
          move_up = { "<C-k>", "<Up>" },
        },
        debug = {
          enabled = false,
          --   show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
        },
      }
    end,
  },
  -- Snacks picker
  -- {
  --   "madmaxieee/fff-snacks.nvim",
  --   dependencies = {
  --     "dmtrKovalenko/fff.nvim",
  --     "folke/snacks.nvim",
  --   },
  --   cmd = "FFFSnacks",
  --   lazy = false,
  --   keys = {
  --     -- {
  --     --   "<leader><space>",
  --     --   function()
  --     --     require("fff-snacks").find_files()
  --     --   end,
  --     --   desc = "FFF find files",
  --     -- },
  --     {
  --       "<leader>gr",
  --       function()
  --         require("fff-snacks").live_grep {
  --           grep_mode = { "fuzzy", "plain", "regex" },
  --         }
  --       end,
  --       desc = "FFF live grep",
  --     },
  --   },
  -- },
}
