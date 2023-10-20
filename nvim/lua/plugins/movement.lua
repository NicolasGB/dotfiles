return {
    {
        'smoka7/hop.nvim',
        version = "*", -- optional but strongly recommended
        event = "VeryLazy",
        dependencies = {
            -- This is a hack to avoid flash registering before
            "folke/flash.nvim",
        },
        config = function()
            local hop = require("hop")
            hop.setup({})

            vim.keymap.set('n', 'f', function()
                hop.hint_words({ multi_windows = true })
            end, { noremap = true, silent = true })

            vim.keymap.set('n', 't', function()
                hop.hint_char1({ current_line_only = true })
            end, { noremap = true, silent = true })

            -- Set highlight based on everforest (leave after setup)
            vim.api.nvim_set_hl(0, 'HopNextKey', { fg = '#E69875', bold = true, ctermfg = 198, cterm = { bold = true } })
            vim.api.nvim_set_hl(0, 'HopNextKey1', { fg = '#A7C080', bold = true, ctermfg = 198, cterm = { bold = true } })
            vim.api.nvim_set_hl(0, 'HopNextKey2', { fg = '#A7C080', bold = true, ctermfg = 198, cterm = { bold = true } })
        end,
    },
    {
        "folke/flash.nvim",
        event  = "VeryLazy",
        keys   = {
            -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "S",
                mode = { "n", "x", "o" },
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter"
            },
        },
        config = function()
            local Flash = require("flash")
            Flash.setup({})

            vim.cmd('highlight CustomFlash guifg=#A7C080 guibg=NONE ctermfg=red ctermbg=NONE')
            vim.cmd('highlight CustomFlash2 guifg=#A7C080 guibg=NONE ctermfg=red ctermbg=NONE')

            -- Remote flash
            vim.keymap.set('o', "r", Flash.remote, { noremap = true, silent = true })
        end
    }
}
