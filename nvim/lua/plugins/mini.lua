return {
  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter
      require("mini.ai").setup {
        custom_textobjects = {
          f = spec_treesitter { a = "@function.outer", i = "@function.inner" },
        },
      }
    end,
  },
  {
    "echasnovski/mini.diff",
    version = "*",
    config = function()
      require("mini.diff").setup {
        view = {
          -- Signs used for hunks with 'sign' view
          signs = { add = "│", change = "│", delete = "_" },
        },
        mappings = {
          goto_prev = "gnd",
          goto_next = "gpd",
        },
      }
    end,
  },
  -- {
  --   "echasnovski/mini.surround",
  --   version = "*",
  --   config = function()
  --     local spec_treesitter = require("mini.ai").gen_spec.treesitter
  --     require().setup {
  --       custom_textobjects = {
  --         f = spec_treesitter { a = "@function.outer", i = "@function.inner" },
  --       },
  --     }
  --   end,
  -- },
}
