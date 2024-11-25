return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "leiserfg/blink_luasnip",
      {
        "saghen/blink.compat",
        opts = { impersonate_nvim_cmp = true },
      },
    },
    build = "cargo build --release",
    -- version = "v0.*",
    config = function()
      require("blink.cmp").setup {
        -- Keymaps
        keymap = {
          preset = "default",
          ["<C-y>"] = { "accept", "fallback" },
        },
        -- Allow expansion
        opts_extend = { "sources.completion.enabled_providers" },

        -- General config later
        accept = {
          expand_snippet = function(snippet)
            require("luasnip").lsp_expand(snippet)
          end,
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
            auto_show_delay = 50,
          },
          signature_help = {
            border = "rounded",
          },
        },
        sources = {
          -- add lazydev to sources
          completion = {
            enabled_providers = { "lsp", "path", "luasnip", "buffer", "lazydev" },
          },
          providers = {
            -- dont show LuaLS require statements when lazydev has items
            lsp = { fallback_for = { "lazydev" } },
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
            -- Luasnip
            luasnip = {
              name = "luasnip",
              module = "blink_luasnip",

              score_offset = -1,

              opts = {
                use_show_condition = false,
                show_autosnippets = true,
              },
            },
          },
        },
      }
    end,
  },
}
