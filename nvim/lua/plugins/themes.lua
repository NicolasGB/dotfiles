return {

    { "catppuccin/nvim",             name = "catppuccin" },
    { "rose-pine/neovim",            name = "rose-pine" },
    { "rmehri01/onenord.nvim",       branch = 'main' },
    { "marko-cerovac/material.nvim", name = "material" },
    {
        "neanias/everforest-nvim",
        config = function()
            require("everforest").setup({
                background = "hard",
            })
        end,
        lazy = false,
        priority = 1,
    },
}
