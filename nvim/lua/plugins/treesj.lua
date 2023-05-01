return {
    'Wansmer/treesj',
    keys = {
        { 'gT', function() require('treesj').toggle() end },
        { 'gJ', function() require('treesj').join() end },
        { 'gS', function() require('treesj').split() end },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('treesj').setup({ --[[ your config ]] })
    end,
}
