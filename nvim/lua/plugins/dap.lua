return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      ui.setup()
      require("dap-go").setup()

      -- Listeners to auto open dap
      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end

      -- Toggle breakpoint
      vim.keymap.set("n", "<leader>bp", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      -- Debug navigation
      vim.keymap.set("n", "<F6>", dap.continue, { desc = "Debug continue" })
      vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Debug step into" })
      vim.keymap.set("n", "<F8>", dap.step_over, { desc = "Debug step over" })
      vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug step out" })
      vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Debug step back" })

      -- Restart debug session
      vim.keymap.set("n", "<F10>", dap.restart, { desc = "Restart debug" })

      -- Open ui
      vim.keymap.set("n", "<leader>db", ui.toggle, { desc = "Toggle dapui" })

      -- Eval var under cursor
      vim.keymap.set("n", "<leader>?", function()
        ui.eval(nil, { enter = true })
      end)
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      -- Change hl group for better visibility
      vim.api.nvim_set_hl(
        0,
        "NvimDapVirtualText",
        { fg = "#FFFFED", bold = true, ctermfg = 198, cterm = { bold = true } }
      )

      require("nvim-dap-virtual-text").setup {
        virt_text_pos = "inline",
      }
    end,
  },
}
