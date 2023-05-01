return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-treesitter/nvim-treesitter" }
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
        vim.api.nvim_set_keymap(
            "v",
            "<leader>rr",
            "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
            { noremap = true }
        )
    end,
}
