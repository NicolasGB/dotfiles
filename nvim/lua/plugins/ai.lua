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
            accept = "<TAB>",
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
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      nes = {
        enabled = false,
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function()
          require("sidekick.cli").focus()
        end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
      {
        "<leader>aa",
        function()
          require("sidekick.cli").toggle { focus = true }
        end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").select_prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
    },
  },
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
                default = "claude-sonnet-4.5",
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
  -- Amp Plugin
  {
    "sourcegraph/amp.nvim",
    branch = "main",
    lazy = false,
    opts = { auto_start = true, log_level = "info" },
  },
}
