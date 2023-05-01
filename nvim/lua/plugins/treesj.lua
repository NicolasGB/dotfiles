return {
    'Wansmer/treesj',
    keys = {
        { 'gT',         function() require('treesj').toggle() end },
        { '<leader>jn', function() require('treesj').join() end },
        { '<leader>sp', function() require('treesj').split() end },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('treesj').setup({ --[[ your config ]] })
    end,
}
