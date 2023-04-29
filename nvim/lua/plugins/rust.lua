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
                            -- this doesn't seem to do nothing
                            inlayHints = {
                                lifetimeElisionHints = {
                                    enable = true,
                                    useParameterNames = true
                                }
                            }
                        },
                    },
                    standalone = false,
                    cmd = { "rustup", "run", "stable", "rust-analyzer" },
                },
                dap = {
                    adapter = "executable",
                    command = "lldb_vscode",
                    name = "rt_lldb",
                }
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
    },
}
