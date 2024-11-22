return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "saghen/blink.compat",
      opts = { impersonate_nvim_cmp = true },
    },
    build = "cargo build --release",
    -- version = "v0.*",
    config = function()
      require("blink.cmp").setup {
        keymap = {
          preset = "default",
          ["<C-y>"] = { "accept", "fallback" },
        },
        opts_extend = { "sources.completion.enabled_providers" },
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
            ---@diagnostic disable-next-line: missing-fields
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
        sources = {
          -- add lazydev to sources
          completion = {
            enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
          },
          providers = {
            -- dont show LuaLS require statements when lazydev has items
            ---@diagnostic disable-next-line: missing-fields
            lsp = { fallback_for = { "lazydev" } },
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
          },
        },
      }
    end,
  },
}
