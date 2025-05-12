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
          -- Toggle out
          vim.keymap.set("t", "q", function()
            term:toggle()
          end, { buffer = term.bufnr, desc = "Toggle Gitme" })
          -- Exit for good
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

      -- Open by default bacon in background for rust files
      vim.g.bacon_setup = false
      local bacon_group = vim.api.nvim_create_augroup("BaconAutoOpen", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        group = bacon_group,
        callback = function()
          if not vim.g.bacon_setup then
            -- Add the bacon keymap
            vim.keymap.set("n", "<C-b>", function()
              bacon:toggle()
            end, { desc = "Bacon", noremap = true, silent = true })

            -- Toggle it open and close it immediately to start scanning
            bacon:toggle()
            bacon:toggle()
            vim.g.bacon_setup = true
          end
        end,
      })
    end,
  },
}
