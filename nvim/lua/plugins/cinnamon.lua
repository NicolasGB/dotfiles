return {
  {
    "declancm/cinnamon.nvim",
    config = function()
      require("cinnamon").setup {
        keymaps = { extra = false },
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
    end,
  },
}
