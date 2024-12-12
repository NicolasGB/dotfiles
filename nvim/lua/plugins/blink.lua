---@diagnostic disable: missing-fields
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
        opts_extend = { "sources.default" },

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

        completion = {
          menu = {
            -- Better highlights and roudnded text
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            -- Similar to nvim cmp visually
            draw = {
              -- Add treesitter highlighting on labels
              treesitter = true,
              columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay = 50,
            window = {
              border = "rounded",
            },
          },
        },
        signature = {
          enabled = true,
          window = {
            border = "rounded",
          },
        },
        sources = {
          -- default = { "lsp", "path", "luasnip", "buffer", "lazydev" },
          default = function()
            local node = vim.treesitter.get_node()
            if vim.bo.filetype == "lua" then
              return { "lsp", "path", "luasnip", "lazydev" }
            elseif vim.bo.filetype == "proto" then
              return { "buffer", "path" }
            elseif node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
              return { "buffer" }
            else
              return { "lsp", "path", "luasnip" }
            end
          end,

          -- add lazydev to sources
          providers = {
            -- dont show LuaLS require statements when lazydev has items
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
            luasnip = { score_offset = 0 },
            path = { score_offset = 0 },
            buffer = { score_offset = -3 },
          },
        },
      }

      -- Highlights
      vim.api.nvim_set_hl(0, "BLinkCmpLabelMatch", { fg = "#D699B6" })
    end,
  },
}
