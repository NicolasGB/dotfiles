return {
    {
        "jremmen/vim-ripgrep",
        config = function()
            vim.g.rg_command = 'rg --vimgrep -S'
        end
    }
}

