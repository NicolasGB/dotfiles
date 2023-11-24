return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
        { "nvim-telescope/telescope.nvim" }
    },
    config = function()
        require("refactoring").setup({
            prompt_func_return_type = {
                go = true
            },
            prompt_func_param_type = {
                go = true
            },
        })

        -- Telescope
        require("telescope").load_extension("refactoring")

        -- remap to open the Telescope refactoring menu in visual mode

        vim.keymap.set(
            "x",
            "<leader>rr",
            function() require('telescope').extensions.refactoring.refactors() end
        )
    end,
}
