return {
  {
    "rachartier/tiny-cmdline.nvim",
    init = function()
      require("vim._core.ui2").enable {}
      vim.o.cmdheight = 0
    end,
    config = function()
      require("tiny-cmdline").setup {
        native_types = {},
        on_reposition = require("tiny-cmdline").adapters.blink,
      }
    end,
  },
}
