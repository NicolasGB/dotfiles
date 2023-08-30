return {
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require("symbols-outline").setup({
                wrap = true,
                width = 30,
                -- auto_close = true,
            })
            vim.keymap.set("n", "<leader>vs", ":SymbolsOutline<CR>")
        end

    }
}
