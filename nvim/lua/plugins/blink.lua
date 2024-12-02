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
      local ls = require "luasnip"
      require("blink.cmp").setup {
        -- Snippets
        snippets = {
          expand = function(snippet)
            ls.lsp_expand(snippet)
          end,
          active = function(filter)
            if filter and filter.direction then
              return ls.jumpable(filter.direction)
            end
            return ls.in_snippet()
          end,
          jump = function(direction)
            ls.jump(direction)
          end,
        },
        -- Keymaps
        keymap = {
          preset = "default",
          ["<C-y>"] = { "accept", "fallback" },
        },
        -- Allow expansion
        opts_extend = { "sources.completion.enabled_providers" },
        -- Appearance
        ---@diagnostic disable-next-line: missing-fields
        appearance = {
          use_nvim_cmp_as_default = true,
        },

        -- General config later
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
        ---@diagnostic disable-next-line: missing-fields
        completion = {
          ---@diagnostic disable-next-line: missing-fields
          menu = {
            -- Better highlights and roudnded text
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            -- Similar to nvim cmp visually
            draw = {
              columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            },
          },
          ---@diagnostic disable-next-line: missing-fields
          documentation = {
            auto_show = true,
            auto_show_delay = 50,
            ---@diagnostic disable-next-line: missing-fields
            window = {
              border = "rounded",
            },
          },
          signature = {
            enabled = true,
            window = {
              border = "rounded",
            },
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
