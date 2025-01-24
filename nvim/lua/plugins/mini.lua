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
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter
      require().setup {
        custom_textobjects = {
          f = spec_treesitter { a = "@function.outer", i = "@function.inner" },
        },
      }
    end,
  },
}
