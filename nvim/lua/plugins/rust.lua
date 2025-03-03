return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    dependencies = {},
    init = function()
      -- Configure rustaceanvim here
      vim.g.rustaceanvim = {
        tools = {
          float_win_config = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
          },
        },
        server = {
          on_attach = function(_, b)
            vim.lsp.inlay_hint.enable(true, { bufnr = b })
          end,
          settings = {
            ["rust-analyzer"] = {
              cargo = { features = "all" },
              assist = {
                importEnforceGranularity = true,
                importPrefix = "module",
              },
              checkOnSave = {
                enable = true,
                command = "clippy",
                features = "all",
              },
              inlayHints = {
                lifetimeElisionHints = {
                  enable = true,
                  useParameterNames = true,
                },
              },
              procMacro = {
                enable = true,
              },
            },
          },
          -- standalone = true,
          -- cmd = { "rustup", "run", "stable", "rust-analyzer" },
          -- cmd = { "/usr/bin/rust-analyzer" },
        },
        -- DAP configuration
        dap = {},
      }
    end,
    ft = { "rust" },
  },
  {
    "saecki/crates.nvim",
    config = function()
      local crates = require "crates"
      crates.setup {
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      }
      crates.show()
    end,
  },
  {
    "nwiizo/cargo.nvim",
    build = "cargo build --release",
    config = function()
      require("cargo").setup {
        float_window = true,
        window_width = 0.8,
        window_height = 0.8,
        border = "rounded",
        auto_close = true,
        close_timeout = 5000,
      }
    end,
    ft = { "rust" },
    cmd = {
      "CargoBench",
      "CargoBuild",
      "CargoClean",
      "CargoDoc",
      "CargoNew",
      "CargoRun",
      "CargoTest",
      "CargoUpdate",
    },
  },
}
