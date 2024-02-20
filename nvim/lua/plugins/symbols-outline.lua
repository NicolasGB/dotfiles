return {
    -- {
    --     'simrat39/symbols-outline.nvim',
    --     config = function()
    --         require("symbols-outline").setup({
    --             wrap = true,
    --             width = 30,
    --             -- auto_close = true,
    --         })
    --         -- vim.keymap.set("n", "<leader>vs", ":SymbolsOutline<CR>")
    --     end
    --
    -- },
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = { -- Example mapping to toggle outline
            { "<leader>vs", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {
            -- Your setup opts here
            outline_window = {
                wrpa = true,
                width = 30,
            }
        },
    },
}
