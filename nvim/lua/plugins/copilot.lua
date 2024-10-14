return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        -- Set
        suggestion = {
          auto_trigger = false,
          keymap = {
            accept = "<A-m>",
            next = "<A-g>",
          },
        },
        --
        filetypes = {
          yaml = true,
          markdown = true,
          rust = false,
          TelescopePrompt = false,
        },
      }

      -- Toggle copilot autogrigger, useful when writing mocks etc
      vim.keymap.set("n", "<leader>cat", function()
        require("copilot.suggestion").toggle_auto_trigger()
      end, { desc = "Copilot toggle auto_trigger" })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    version = "^v2",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    config = function()
      require("CopilotChat").setup {
        debug = true, -- Enable debugging
        -- See Configuration section for rest
      }

      -- -- Trigger quick chat
      vim.keymap.set("n", "<leader>ccq", function()
        local input = vim.fn.input "Quick Chat: "
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
        end
      end, { desc = "CopilotChat - Quick chat" })

      -- Quick chat with visual selection
      vim.keymap.set("v", "<leader>ccq", function()
        local input = vim.fn.input "Quick Chat: "
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
        end
      end, { desc = "CopilotChat - Quick chat visual" })

      -- -- Trigger actions
      vim.keymap.set({ "n", "v" }, "<leader>ccp", function()
        local actions = require "CopilotChat.actions"
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end, { noremap = true, desc = "CopilotChat - Prompt actions" })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
