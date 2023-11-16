return {
    {
        'mrcjkb/rustaceanvim',
        version = '^3', -- Recommended
        dependencies = {},
        init = function()
            -- Configure rustaceanvim here
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(_, bufnr)
                        vim.lsp.inlay_hint.enable(bufnr, true)
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
                            }
                        },
                    },
                    standalone = true,
                    cmd = { "rustup", "run", "stable", "rust-analyzer" },
                },
            }
        end,
        ft = { 'rust' },
    },
    -- {
    --     'simrat39/rust-tools.nvim',
    --     -- 'Ciel-MC/rust-tools.nvim',
    --     ft = { 'rust' },
    --     config = function()
    --         -- Debugger
    --         -- Update this path
    --         local extension_path = vim.env.HOME .. '/.vscode-oss/extensions/vadimcn.vscode-lldb-1.9.2-universal/'
    --         local codelldb_path = extension_path .. 'adapter/codelldb'
    --         local liblldb_path = extension_path .. 'lldb/lib/liblldb'
    --         local this_os = vim.loop.os_uname().sysname;
    --
    --         -- The path in windows is different
    --         if this_os:find "Windows" then
    --             codelldb_path = extension_path .. "adapter\\codelldb.exe"
    --             liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
    --         else
    --             -- The liblldb extension is .so for linux and .dylib for macOS
    --             liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
    --         end
    --
    --         -- Rust tools config
    --         local rust_tools = require("rust-tools")
    --
    --         rust_tools.setup({
    --             tools = {
    --                 runnables = {
    --                     use_telescope = true,
    --                 },
    --                 inlay_hints = {
    --                     auto = true,
    --                     show_parameter_hints = true,
    --                 },
    --                 hover_actions = {
    --                     auto_focus = true,
    --                 }
    --             },
    --             server = {
    --                 on_attach = function()
    --                     vim.keymap.set('n', '<leader>ha', rust_tools.hover_actions.hover_actions, { buffer = bufnr })
    --                 end,
    --                 settings = {
    --                     ["rust-analyzer"] = {
    --                         cargo = { features = "all" },
    --                         assist = {
    --                             importEnforceGranularity = true,
    --                             importPrefix = "crate"
    --                         },
    --                         checkOnSave = {
    --                             enable = true,
    --                             command = "clippy",
    --                             features = "all",
    --                         },
    --                         -- this doesn't seem to do nothing
    --                         inlayHints = {
    --                             lifetimeElisionHints = {
    --                                 enable = true,
    --                                 useParameterNames = true
    --                             }
    --                         }
    --                     },
    --                 },
    --                 standalone = true,
    --                 -- Chose whichever fits based on the project needs
    --                 cmd = { "rustup", "run", "stable", "rust-analyzer" },
    --                 -- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    --             },
    --             dap = {
    --                 adapter = require('rust-tools.dap').get_codelldb_adapter(
    --                     codelldb_path, liblldb_path)
    --             },
    --         })
    --     end
    -- },
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
            -- set keymaps

            vim.keymap.set('n', '<leader>cr', crates.reload, { desc = "Reload crates.nvim", silent = true })

            vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, { desc = "Show versions popup", silent = true })
            vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { desc = "Show features popup", silent = true })
            vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup,
                { desc = "Show dependencies popup", silent = true })

            vim.keymap.set('n', '<leader>cu', crates.update_crate, { desc = "Update crate", silent = true })
            vim.keymap.set('v', '<leader>cu', crates.update_crates, { desc = "Update crates", silent = true })
            vim.keymap.set('n', '<leader>ca', crates.update_all_crates, { desc = "Update all crates", silent = true })
            vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { desc = "Upgrade crate", silent = true })
            vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { desc = "Upgrade crates", silent = true })
            vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, { desc = "Upgrade all crates", silent = true })

            vim.keymap.set('n', '<leader>cH', crates.open_homepage, { desc = "Open homepage", silent = true })
            vim.keymap.set('n', '<leader>cR', crates.open_repository, { desc = "Open repository", silent = true })
            vim.keymap.set('n', '<leader>cD', crates.open_documentation, { desc = "Open documentation", silent = true })
            vim.keymap.set('n', '<leader>cC', crates.open_crates_io, { desc = "Open crates.io", silent = true })
        end,
    },
}
