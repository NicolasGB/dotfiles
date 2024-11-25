return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./custom-snippets" } }

      local ls = require "luasnip"
      local types = require "luasnip.util.types"

      ls.config.setup {}

      -- Setup keybindings to tab
      local function feedkey(key, mode)
        vim.fn.feedkeys(vim.keycode(key), mode or vim.api.nvim_get_mode().mode)
      end

      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        return ls.locally_jumpable() and ls.jump(1) or feedkey("<Tab>", "n")
      end, { desc = "Luasnip - Jump to next node" })

      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        return ls.in_snippet() and ls.jumpable(-1) and ls.jump(-1) or feedkey("<S-Tab>", "n")
      end, { desc = "Luasnip - Jump to previous node" })

      -- Setup toggle choice
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },
}
