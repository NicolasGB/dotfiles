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
            require("copilot").setup({
                -- Set
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        accept = "<A-m>",
                    }
                },
                --
                filetypes = {
                    yaml = true,
                    markdown = true,
                    rust = false,
                    TelescopePrompt = false
                }
            })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        keys = {
            {
                "<leader>ccq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                    end
                end,
                desc = "CopilotChat - Quick chat",
            },
            {
                "<leader>ccp",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - Prompt actions",
            },
        },
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
        },
        opts = {
            debug = true, -- Enable debugging
            -- See Configuration section for rest
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
