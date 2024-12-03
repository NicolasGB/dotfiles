return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    config = function()
      -- Diagnostics
      vim.diagnostic.config {
        -- virtual_text = {
        --   prefix = "●",
        -- },
        virtual_text = false,
        -- update_in_insert = true,
        underline = true,
        severity_sort = true,

        float = {
          severity_sort = true,
          header = "Diagnostics",
          source = "if_many",
          prefix = "• ",

          border = "rounded",
        },
        signs = {
          -- Set nice text signs
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      }

      require("tiny-inline-diagnostic").setup {
        preset = "modern",
        options = {
          -- If multiple diagnostics are under the cursor, display all of them.
          multiple_diag_under_cursor = true,
          -- Enable diagnostic message on all lines.
          multilines = true,
          -- Show all diagnostics on the cursor line.
          show_all_diags_on_cursorline = true,
          -- Avoid conflict with gitsigns
          virt_exts = {
            priority = 2048,
          },
        },
      }
    end,
  },
}
