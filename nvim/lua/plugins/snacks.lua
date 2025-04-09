return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      profiler = { enabled = true },
      image = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      explorer = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
      lazygit = {
        win = { border = "rounded" },
      },
      picker = {
        enabled = true,
        previewers = {
          diff = {
            builtin = false,
            cmd = { "delta" },
          },
          git = {
            native = true,
          },
        },
        win = {
          input = {
            keys = {
              ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
              ["<leader>q"] = { "qflist_all", mode = { "n" } },
            },
          },
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode"},
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History"},
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File"},
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse"},
      { "<leader>go", function() Snacks.gitbrowse({what = "repo"}) end, desc = "Git open repo"},
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History"},
      { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit"},
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications"},
      { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal"},
      { "<leader>N", desc = "Neovim News", function() Snacks.win { 
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1], width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          }
        end,
      },
      -- Pickers
      -- Explorer
      { "<leader>ft", function () Snacks.explorer() end, desc = "File tree" },
      -- Files and text
      { "<leader>ff", function() Snacks.picker.files({cmd = "fd", hidden = true}) end, desc = "Find Files"},
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers"},
      { "<leader>gr", function() Snacks.picker.grep({hidden = true}) end, desc = "Grep in files"},
      { "<leader>rr", function() Snacks.picker.resume() end, desc = "Resume search"},
      { "<leader>sc", function() Snacks.picker.lines() end, desc = "Search in current buffer"},
      { "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "Grep buffers"},
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" }},
      { "<leader><space>", function() Snacks.picker.files({hidden = true}) end, desc = "Smart picker"},
      -- Keymaps
      { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Find keymaps"},
      -- Commands
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
       -- git
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      -- Nvim help
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>le", function() Snacks.picker.diagnostics_buffer() end, desc = "Goto T[y]pe Definition" },
      -- TODO
      { "<leader>td", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      -- stylua: ignore end
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Enable input
          Snacks.input.enable()

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
          Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
          Snacks.toggle.diagnostics():map "<leader>ud"
          Snacks.toggle.line_number():map "<leader>ul"
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map "<leader>uc"
          Snacks.toggle.treesitter():map "<leader>uT"
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
          Snacks.toggle.inlay_hints():map "<leader>uh"
          Snacks.toggle.indent():map "<leader>ug"
          Snacks.toggle.dim():map "<leader>uD"
        end,
      })
    end,
  },
}
