return {
  {
    "declancm/cinnamon.nvim",
    version = "1.2.3",
    config = function()
      require("cinnamon").setup {
        keymaps = { basic = true },
        options = {
          max_delta = {
            line = 150,
          },
        },
      }
      local cinnamon = require "cinnamon"

      -- Centered scrolling:
      vim.keymap.set("n", "<C-u>", function()
        cinnamon.scroll "<C-u>zz"
      end)
      vim.keymap.set({ "n", "x" }, "<C-d>", function()
        cinnamon.scroll "<C-d>zz"
      end)
      vim.keymap.set({ "n", "x" }, "G", function()
        cinnamon.scroll "Gzz"
      end)
      vim.keymap.set({ "n", "x" }, "gg", function()
        cinnamon.scroll "gg"
      end)

      vim.keymap.set({ "n", "x" }, "]]", function()
        cinnamon.scroll "]]zz"
      end)
      vim.keymap.set({ "n", "x" }, "[[", function()
        cinnamon.scroll "[[zz"
      end)

      -- Line scroll
      vim.keymap.set({ "n", "v" }, "H", function()
        cinnamon.scroll "^"
      end)
      vim.keymap.set({ "n", "v" }, "L", function()
        cinnamon.scroll "$"
      end)
      vim.keymap.set({ "n", "x" }, "0", function()
        cinnamon.scroll "0"
      end)

      -- End
      vim.keymap.set({ "n", "x" }, "e", function()
        cinnamon.scroll "e"
      end)
      vim.keymap.set({ "n", "x" }, "E", function()
        cinnamon.scroll "E"
      end)
      -- Backward
      vim.keymap.set({ "n", "x" }, "b", function()
        cinnamon.scroll "b"
      end)
      vim.keymap.set({ "n", "x" }, "B", function()
        cinnamon.scroll "B"
      end)
    end,
  },
}
