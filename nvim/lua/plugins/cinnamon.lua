return {
    {
        'declancm/cinnamon.nvim',
        event = "VeryLazy",
        config = function()
            require('cinnamon').setup {
                extra_keymaps = true,
                extended_keymaps = false,
                override_keymaps = false,
                max_length = 500,
                centered = true,
                scroll_limit = 500,
            }

            -- We like it centered
            vim.keymap.set({ 'n', 'x' }, 'G', "<Cmd>lua Scroll('G', 0, 1)<CR>zz")
        end
    }
}
