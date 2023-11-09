return {
    {
        'smoka7/hop.nvim',
        version = "*", -- optional but strongly recommended
        event = "VeryLazy",
        dependencies = {
        },
        config = function()
            local hop = require("hop")
            hop.setup({})

            -- Default hops
            vim.keymap.set('n', 'f', function()
                hop.hint_words({ multi_windows = true })
            end, { noremap = true, silent = true })

            vim.keymap.set('n', 't', function()
                hop.hint_char1({ current_line_only = true })
            end, { noremap = true, silent = true })

            -- Treesitter hop
            vim.keymap.set('n', '<leader>n', function()
                require("hop-treesitter").hint_nodes()
            end, { noremap = true, silent = true })

            -- Camel Case hop
            vim.keymap.set('n', '<leader>c', ":HopCamelCaseMW<CR>", { noremap = true, silent = true })

            -- Remote yanking and pasting
            vim.keymap.set("n", "<leader>yr", function()
                require("hop-yank").yank_char1()
            end, { noremap = true, silent = true })

            vim.keymap.set("n", "<leader>pr", function()
                require("hop-yank").paste_char1()
            end, { noremap = true, silent = true })

            -- Set highlight based on everforest (leave after setup)
            vim.api.nvim_set_hl(0, 'HopNextKey', { fg = '#E69875', bold = true, ctermfg = 198, cterm = { bold = true } })
            vim.api.nvim_set_hl(0, 'HopNextKey1', { fg = '#A7C080', bold = true, ctermfg = 198, cterm = { bold = true } })
            vim.api.nvim_set_hl(0, 'HopNextKey2', { fg = '#A7C080', bold = true, ctermfg = 198, cterm = { bold = true } })
        end,
    },
}
