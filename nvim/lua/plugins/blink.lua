return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",

    dependencies = {
      -- This is already init in its file ./luasnip.lua
      "saghen/blink.compat",
    },
    build = "cargo build --release",
    -- version = "v0.*",
    config = function()
      require("blink.cmp").setup {
        keymap = {
          preset = "enter",
          ["<C-y>"] = { "accept", "fallback" },
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        trigger = {
          signature_help = {
            enabled = true,
          },
        },
        highlight = {
          use_nvim_cmp_as_default = true,
        },
        windows = {
          autocomplete = {
            -- Better highlights and roudnded text
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",

            -- Similar to nvim cmp visually
            draw = {
              columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            },
          },
          documentation = {
            border = "rounded",
            auto_show = true,
          },
          signature_help = {
            border = "rounded",
          },
        },
      }
    end,
  },
}
