return {
    {
        'simrat39/rust-tools.nvim',
        ft = { 'rust' },
        config = function()
            local rust_tools = require("rust-tools")

            rust_tools.setup({
                tools = {
                    runnables = {
                        use_telescope = true,
                    },
                    inlay_hints = {
                        auto = true,
                        show_parameter_hints = true,
                    },
                    hover_actions = {
                        auto_focus = true,
                    }
                },
                server = {
                    on_attach = function()
                        vim.keymap.set('n', '<leader>ha', rust_tools.hover_actions.hover_actions, { buffer = bufnr })
                    end,
                    settings = {
                        ["rust-analyzer"] = {
                            -- enable clippy on save
                            checkOnSave = {
                                command = "clippy",
                            },
                        },
                    },
                },
            })
        end
    },
    {
        "saecki/crates.nvim",
        config = function()
            local crates = require("crates")
            crates.setup()
            crates.show()
        end,
    }
}
