return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        size = 15,
        open_mapping = [[<C-t>]],
        direction = "float",
        on_open = function(term)
          -- Map ESC to exit terminal mode in any toggleterm terminal
          vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = term.bufnr })
        end,
      }

      -- Lazy docker terminal
      local Terminal = require("toggleterm.terminal").Terminal
      local lazydocker = Terminal:new {
        cmd = "lazydocker",
        hidden = true,
        direction = "float",
        close_on_exit = false,
        on_open = function(term)
          vim.keymap.set("t", "q", function()
            term:toggle()
          end, { buffer = term.bufnr, desc = "Toggle lazydocker" })
          vim.keymap.set("t", "Q", function()
            term:shutdown()
          end, { buffer = term.bufnr, desc = "Close lazydocker" })
        end,
      }

      local gitme = Terminal:new {
        cmd = "gitme",
        hidden = true,
        direction = "float",
        close_on_exit = false,
        on_open = function(term)
          vim.keymap.set("t", "q", function()
            term:toggle()
          end, { buffer = term.bufnr, desc = "Toggle Gitme" })
          vim.keymap.set("t", "Q", function()
            term:shutdown()
          end, { buffer = term.bufnr, desc = "Close Gitme" })
        end,
      }
      local bacon = Terminal:new {
        cmd = "bacon",
        hidden = true,
        direction = "float",
        close_on_exit = false,
        on_open = function(term)
          vim.keymap.set("t", "<C-b>", function()
            term:toggle()
          end, { buffer = term.bufnr, desc = "Toggle bacon" })
          vim.keymap.set("t", "q", function()
            term:shutdown()
          end, { buffer = term.bufnr, desc = "Toggle bacon" })
        end,
      }

      -- Setup lazydocker toggle
      vim.keymap.set("n", "<leader>ld", function()
        lazydocker:toggle()
      end, { desc = "Lazydocker", noremap = true, silent = true })
      -- Setup gitme toggle
      vim.keymap.set("n", "<leader>gm", function()
        gitme:toggle()
      end, { desc = "Gitme", noremap = true, silent = true })

      vim.keymap.set("n", "<C-b>", function()
        bacon:toggle()
      end, { desc = "Bacon", noremap = true, silent = true })
    end,
  },
}
