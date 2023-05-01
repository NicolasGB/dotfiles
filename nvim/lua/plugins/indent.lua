return {
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                indent_blankline_use_treesitter = true,
                show_trailing_blankline_indent = false,
            })
        end
    }
}
