return {
    {
        "ray-x/sad.nvim",
        dependencies = {
            "ray-x/guihua.lua",
        },
        config = function()
            require("sad").setup({})
            vim.keymap.set("v", "<leader>sad", ":<C-u>Sad<CR>")
        end
    }
}
