return {
    {
        'mrcjkb/rustaceanvim',
        version = '^4', -- Recommended
        dependencies = {},
        init = function()
            -- Configure rustaceanvim here
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(_, b)
                        vim.lsp.inlay_hint.enable(true, { bufnr = b })
                    end,
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = { features = "all" },
                            assist = {
                                importEnforceGranularity = true,
                                importPrefix = "crate"
                            },
                            checkOnSave = {
                                enable = true,
                                command = "clippy",
                                features = "all",
                            },
                            inlayHints = {
                                lifetimeElisionHints = {
                                    enable = true,
                                    useParameterNames = true
                                }
                            },
                        },
                    },
                    standalone = true,
                    -- cmd = { "rustup", "run", "stable", "rust-analyzer" },
                    cmd = { "/usr/bin/rust-analyzer" }
                },
                -- DAP configuration
                dap = {},
            }
        end,
        ft = { 'rust' },
    },
    {
        "saecki/crates.nvim",
        config = function()
            local crates = require("crates")
            crates.setup {
                src = {
                    cmp = {
                        enabled = true,
                    },
                },
            }
            crates.show()
        end,
    },
}
