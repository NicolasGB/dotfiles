return {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
        vim.cmd("hi HopNextKey guifg=#18dede")
        vim.cmd("hi HopNextKey1 guifg=#18dede")
        vim.cmd("hi HopNextKey2 guifg=#18dede")

        local hop = require("hop")
        local directions = require('hop.hint').HintDirection

        hop.setup({})


        vim.keymap.set('n', 'f', ":HopWordMW<CR>", { noremap = true, silent = true })

        vim.keymap.set('n', 't', ":HopChar1CurrentLine<CR>", { noremap = true, silent = true })
        --
        -- vim.keymap.set('', 'f', function()
        --     hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
        -- end, { remap = true })
        -- vim.keymap.set('', 'F', function()
        --     hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
        -- end, { remap = true })
    end,
}
