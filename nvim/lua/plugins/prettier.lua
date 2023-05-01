return {
    {
        'MunifTanjim/prettier.nvim',
        config = function()
            require("prettier").setup({
                bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
                filetypes = {
                    "graphql",
                    "html",
                    "json",
                    "markdown",
                    "yaml",
                }
            })
        end
    }
}
