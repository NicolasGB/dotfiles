return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./custom-snippets" } })

            local luasnip = require("luasnip")

            luasnip.config.setup({})
        end

    },
    { "saadparwaiz1/cmp_luasnip" }
}
