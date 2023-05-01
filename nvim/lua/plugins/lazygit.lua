return {
    {
        'kdheepak/lazygit.nvim',
        config = function()
            vim.keymap.set('n', '<leader>lg', vim.cmd.LazyGit)
        end
    }
}
