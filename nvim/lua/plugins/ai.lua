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
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   version = "^v3",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
  --     { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  --     { "MeanderingProgrammer/render-markdown.nvim" },
  --   },
  --   build = "make tiktoken",
  --   config = function()
  --     require("render-markdown").setup {
  --       file_types = { --[[ "markdown", ]]
  --         "copilot-chat",
  --       },
  --     }
  --
  --     local chat = require "CopilotChat"
  --
  --     chat.setup {
  --       debug = false, -- Enable debugging
  --       -- See Configuration section for rest
  --       model = "gpt-4.1",
  --       -- model = "gemini-2.5-pro",
  --       mappings = {
  --         reset = {
  --           normal = "<C-x>",
  --           insert = "<C-x>",
  --           callback = function()
  --             return chat.reset()
  --           end,
  --         },
  --       },
  --     }
  --
  --     vim.keymap.set("n", "<leader>cco", function()
  --       chat.open {}
  --     end, { desc = "CopilotChat - Chat open" })
  --
  --     -- -- Trigger quick chat
  --     vim.keymap.set("n", "<leader>ccq", function()
  --       local input = vim.fn.input "Quick Chat: "
  --       if input ~= "" then
  --         chat.ask(input, { selection = require("CopilotChat.select").buffer })
  --       end
  --     end, { desc = "CopilotChat - Quick chat" })
  --
  --     -- Quick chat with visual selection
  --     vim.keymap.set("v", "<leader>ccq", function()
  --       local input = vim.fn.input "Quick Chat: "
  --       if input ~= "" then
  --         chat.ask(input, { selection = require("CopilotChat.select").visual })
  --       end
  --     end, { desc = "CopilotChat - Quick chat visual" })
  --
  --     vim.keymap.set({ "n" }, "<leader>ccc", function()
  --       chat.ask(
  --         "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters. Wrap the whole message in code block with language gitcommit.",
  --         { context = { "git:staged", "git:unstaged" } }
  --       )
  --     end, { desc = "Write a commit message with copilot" })
  --     -- -- Trigger actions
  --     vim.keymap.set({ "n", "v" }, "<leader>ccp", function()
  --       chat.select_prompt {}
  --     end, { noremap = true, desc = "CopilotChat - Prompt actions" })
  --   end,
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "j-hui/fidget.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
      },
      "ravitemer/codecompanion-history.nvim",
    },
    init = function()
      require("plugins.codecompanion.fidget"):init()
    end,
    config = function()
      local cc = require "codecompanion"
      local adapters = require "codecompanion.adapters"

      cc.setup {
        strategies = {
          -- inline = {
          --   adapter = {
          --     name = "copilot",
          --     model = "claude-sonnet-4",
          --     -- model = "gpt-4o",
          --   },
          -- },
          chat = {
            slash_commands = {
              ["buffer"] = {
                keymaps = {
                  modes = {
                    i = "<C-b>",
                    n = { "<C-b>", "gb" },
                  },
                },
                opts = {
                  provider = "snacks",
                },
              },
              ["file"] = {
                opts = {
                  provider = "snacks",
                },
              },
            },
          },
        },
        display = {
          chat = {
            -- show_settings = true,
          },
          action_palette = {
            provider = "snacks",
          },
        },
        adapters = {
          http = {
            copilot = function()
              return adapters.extend("copilot", {
                schema = {
                  model = {
                    -- default = "claude-sonnet-4",
                    default = "gpt-5",
                  },
                },
              })
            end,
          },
        },
        extensions = {
          history = {
            enabled = true,
            opts = {
              keymap = "gh",
              auto_save = true,
              picker = "snacks",
              ---Automatically generate titles for new chats
              auto_generate_title = true,
              title_generation_opts = {
                ---Adapter for generating titles (defaults to current chat adapter)
                adapter = "copilot",
                ---Model for generating titles (defaults to current chat model)
                model = "claude-sonnet-4",
              },
              ---On exiting and entering neovim, loads the last chat on opening chat
              continue_last_chat = false,
              ---When chat is cleared with `gx` delete the chat from history
              delete_on_clearing_chat = false,
              ---Directory path to save the chats
              dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
            },
          },
        },
      }

      vim.keymap.set("n", "<A-i>", function()
        cc.toggle()
        vim.defer_fn(function()
          if vim.bo.filetype == "codecompanion" then
            vim.cmd "startinsert"
          end
        end, 20)
      end, { desc = "AI - Chat open" })

      vim.keymap.set({ "n", "v" }, "<leader>ccp", function()
        cc.actions {}
      end, { noremap = true, desc = "AI - Prompt actions" })

      vim.keymap.set("n", "<leader>ccc", ":CodeCompanion /commit<CR>", { desc = "AI - Generate commit" })
      vim.keymap.set({ "n", "v" }, "<leader>ccq", ":CodeCompanion<CR>", { desc = "AI - Quick prompt " })
    end,
  },
}
