return {
  -- {
  --     "github/copilot.vim",
  --     config = function()
  --         vim.g.copilot_filetypes = {
  --             markdown = true,
  --             yaml = true,
  --             rust = false,
  --             TelescopePrompt = false
  --         }
  --         vim.g.copilot_no_tab_map = true
  --
  --         vim.api.nvim_set_keymap("i", "<A-m>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
  --     end
  -- },
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
      local copilot_chat = require("CopilotChat").setup {
        debug = true, -- Enable debugging
        -- See Configuration section for rest
      }

      -- -- Trigger quick chat
      vim.keymap.set("n", "<leader>ccq", function()
        local input = vim.fn.input "Quick Chat: "
        if input ~= "" then
          copilot_chat.ask(input, { selection = require("CopilotChat.select").buffer })
        end
      end, { desc = "CopilotChat - Quick chat" })
      -- -- Trigger actions
      vim.keymap.set("n", "<leader>ccp", function()
        local actions = require "CopilotChat.actions"
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end, { noremap = true, desc = "CopilotChat - Prompt actions" })

      vim.keymap.set("v", "<leader>ccp", function()
        local actions = require "CopilotChat.actions"
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end, { noremap = true, desc = "CopilotChat - Prompt actions" })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
