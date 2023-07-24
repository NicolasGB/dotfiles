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
                    -- Chose whichever fits based on the project needs
                    -- cmd = { "rustup", "run", "stable", "rust-analyzer" },
                    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
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
            -- set keymaps
            local opts = { silent = true }

            vim.keymap.set('n', '<leader>cr', crates.reload, opts)

            vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts)
            vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts)
            vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts)

            vim.keymap.set('n', '<leader>cu', crates.update_crate, opts)
            vim.keymap.set('v', '<leader>cu', crates.update_crates, opts)
            vim.keymap.set('n', '<leader>ca', crates.update_all_crates, opts)
            vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, opts)
            vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, opts)
            vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, opts)

            vim.keymap.set('n', '<leader>cH', crates.open_homepage, opts)
            vim.keymap.set('n', '<leader>cR', crates.open_repository, opts)
            vim.keymap.set('n', '<leader>cD', crates.open_documentation, opts)
            vim.keymap.set('n', '<leader>cC', crates.open_crates_io, opts)
        end,
    },
}
