return {
    {
        'williamboman/mason.nvim',
        build = ":MasonUpdate",
        opts = {
            ui = {
                border = "rounded"
            }
        }
    },
    { 'williamboman/mason-lspconfig.nvim' },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "gopls",
                    "html-lsp",
                    "json-lsp",
                    "taplo",
                    "lua_ls",
                    "graphql-language-service-cli",
                    "yaml-language-server",
                    "tsserver",
                    "marksman",
                },
                auto_update = true,
            })
        end,
    },
}
