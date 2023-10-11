return {
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            local oil = require("oil")
            oil.setup({
                default_file_explorer = false, -- If i get used to might activate it later
                keymaps = {
                    ["<C-s>"] = "actions.save",
                    ["q"] = "actions.close",
                    ["<A-p>"] = "actions.parent"
                },
                view_options = {
                    show_hidden = true,
                },
            })
            vim.keymap.set("n", "-", oil.open_float, { desc = "Open parent directory" })
        end
    }
}
