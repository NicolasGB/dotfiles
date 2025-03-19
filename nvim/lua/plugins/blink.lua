---@diagnostic disable: missing-fields
return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    build = "cargo build --release",
    -- version = "v0.*",
    config = function()
      -- local ls = require "luasnip"
      require("blink.cmp").setup {
        -- Snippets
        snippets = { preset = "luasnip" },
        -- Keymaps
        keymap = {
          preset = "default",
          -- ["<C-y>"] = { "accept", "fallback" },
          -- Snacks did this to me, bye ctrl n/p
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
        },
        completion = {
          -- General config later
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },

          menu = {
            -- Better highlights and roudnded text
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            -- Similar to nvim cmp visually
            draw = {
              -- Add treesitter highlighting on labels
              -- treesitter = { "lsp" },
              columns = {
                { "label", "label_description", gap = 1 },
                { "kind_icon", "kind", gap = 1 },
                { "source_name", gap = 1 },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 50,
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
        fuzzy = { implementation = "prefer_rust_with_warning" },
        cmdline = {
          keymap = {
            ["<Tab>"] = {
              function(cmp)
                -- If the menu is not visible show it, otherwise accept
                if not cmp.is_menu_visible() then
                  return cmp.show {}
                end
              end,
              "accept",
            },
            ["<C-j>"] = { "select_next" },
            ["<C-k>"] = { "select_prev" },
          },
          completion = {
            menu = {
              auto_show = true,
            },
          },
        },
        sources = {
          -- default = { "lsp", "path", "luasnip", "buffer", "lazydev" },
          default = function()
            -- Fast path: check filetype first
            if vim.bo.filetype == "lua" then
              return { "lsp", "path", "snippets", "lazydev" }
            elseif vim.bo.filetype == "proto" or vim.bo.filetype == "cucumber" or vim.bo.filetype == "yaml" then
              return { "buffer", "path" }
            end

            -- Only get treesitter node if needed
            local node = vim.treesitter.get_node()
            if node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
              return { "buffer" }
            end

            -- Check if the line starts with a comment, in go/rust it seems that the treesitter node is not constantly updated
            -- therefore the source only worked when modifying an already existent comment in the range
            local line_to_cursor = vim.api.nvim_get_current_line():sub(1, select(2, vim.api.nvim_win_get_cursor(0)))
            if line_to_cursor:match "^%s*[//#%-%-]" then
              return { "buffer" }
            end

            -- Otherwise return the defaults
            return { "lsp", "path", "snippets" }
          end,

          -- add lazydev to sources
          providers = {
            -- dont show LuaLS require statements when lazydev has items
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
            snippets = { score_offset = -1 },
            path = { score_offset = 3 },
            buffer = { score_offset = -3 },
          },
        },
      }

      -- Highlights
      vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#D699B6" })
      -- Labels
      vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#d79a66" })
      vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { fg = "#6c7b95" })
      vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = "#56B6C2" })
    end,
  },
}
