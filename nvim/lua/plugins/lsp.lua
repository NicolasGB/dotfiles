return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Mason
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required

            -- Signature
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { "ray-x/lsp_signature.nvim" },

            -- Telescope
            { 'nvim-telescope/telescope.nvim' },

            -- Neodev for vim api lsp
            { "folke/neodev.nvim" },
        },
        config = function()
            -- Set Borders on hovers
            local border_style = 'rounded'
            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = border_style }
            )

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers["signature_help"],
                { border = border_style }
            )

            -- Diagnostics
            vim.diagnostic.config({
                virtual_text = {
                    prefix = '●',
                },
                -- update_in_insert = true,
                underline = true,
                severity_sort = true,

                float = {
                    severity_sort = true,
                    header = "Diagnostics",
                    source = "if_many",
                    prefix = "• ",

                    border = "rounded",
                },
            })

            -- Color Inlay hints highlight matching everforest
            vim.api.nvim_set_hl(0, 'LspInlayHint',
                { fg = '#6C7E8C', bold = true, ctermfg = 198, cterm = { bold = true } })

            -- LspConfig
            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            -- On LSP attach setup telescope mappings with lsp actions
            local telescope = require('telescope.builtin')
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp_keybindings', { clear = true }),
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
                    vim.keymap.set("n", "gt", telescope.lsp_type_definitions, opts)
                    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "ge", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "gpe", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "<leader>le", telescope.diagnostics, opts)
                    -- Good old JetBrains
                    vim.keymap.set("n", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("v", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)

                    vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>R", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                    vim.keymap.set("n", "gr", function() telescope.lsp_references({ include_declaration = false }) end,
                        opts)
                    vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
                end
            })

            -- Lsp Signature Helper
            local _ = require("lsp_signature").setup({
                floating_window = false,
            })

            -- Lsp Default setup
            local default_setup = function(server)
                -- Register given lsp default capabilities
                lspconfig[server].setup({
                    capabilities = lsp_capabilities,
                })
            end

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { 'gopls', 'lua_ls', 'yamlls', 'jsonls', 'taplo', 'typos_lsp' },
                handlers = {
                    default_setup,
                    -- Lua setup
                    lua_ls = function()
                        lspconfig.lua_ls.setup({
                            on_attach = function(_, b)
                                vim.lsp.inlay_hint.enable(b, true)
                            end,
                            settings = {
                                Lua = {
                                    completion = {
                                        callSnippet = "Replace"
                                    },
                                    runtime = {
                                        version = 'LuaJIT',
                                    },
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                    },
                                    hint = {
                                        enable = true,
                                    },
                                },
                            },
                        })
                    end,
                    -- YAML setup
                    yamlls = function()
                        lspconfig.yamlls.setup({
                            settings = {
                                yaml = {
                                    keyOrdering = false
                                }
                            },
                        })
                    end,
                    -- GraphQL setup
                    graphql = function()
                        local util = require 'lspconfig.util'
                        lspconfig.graphql.setup({
                            root_dir = util.root_pattern('.git', '.graphqlrc*', '.graphql.config.*', 'graphql.config.*',
                                '/config/gqlgen.yaml')
                        })
                    end,
                    -- Golang setup
                    gopls = function()
                        lspconfig.gopls.setup({
                            on_attach = function(_, b)
                                vim.lsp.inlay_hint.enable(b, true)
                            end,
                            settings = {
                                gopls = {
                                    directoryFilters = { "-**/graph/generated", "-**/node_modules" },
                                    experimentalPostfixCompletions = true,
                                    analyses = {
                                        unusedparams = true,
                                        unusedresult = true,
                                        shadow = true,
                                    },
                                    staticcheck = true,
                                    hints = {
                                        assignVariableTypes = true,
                                        compositeLiteralFields = true,
                                        compositeLiteralTypes = true,
                                        constantValues = true,
                                        functionTypeParameters = true,
                                        parameterNames = true,
                                        rangeVariableTypes = true,
                                    },
                                    gofumpt = true,
                                },
                            },
                        })
                    end,
                    -- TS Server setup
                    tsserver = function()
                        require("lspconfig").tsserver.setup({
                            on_attach = function(_, b)
                                vim.lsp.inlay_hint.enable(b, true)
                            end,
                            init_options = {
                                preferences = {
                                    includeInlayParameterNameHints = 'all',
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayEnumMemberValueHints = true,
                                    importModuleSpecifierPreference = "non-relative",
                                },
                            },
                            single_file_support = true,
                            root_dir = require("lspconfig.util").root_pattern("package.json"),
                        })
                    end,
                    typos_lsp = function()
                        require('lspconfig').typos_lsp.setup({
                            config              = {
                                -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
                                cmd_env = { RUST_LOG = "ERROR" }
                            },
                            init_options        = {
                                -- Custom config. Used together with any workspace config files, taking precedence for
                                -- settings declared in both. Equivalent to the typos `--config` cli argument.
                                -- config = '~/code/typos-lsp/crates/typos-lsp/tests/typos.toml',
                                -- How typos are rendered in the editor, eg: as errors, warnings, information, or hints.
                                -- Defaults to error.
                                diagnosticSeverity = "Information"
                            },
                            single_file_support = true,
                        })
                    end
                }
            })

            -- Formatting on Save
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("format_lsp_attach", { clear = true }),
                desc = "Lsp autoformat",
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    assert(client, "Client not found")

                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("format_lsp_attach_buffer_" .. tostring(event.buf), {
                                clear = true
                            }),
                            buffer = event.buf,
                            callback = function(ev)
                                vim.lsp.buf.format({
                                    bufnr = ev.buf,
                                    id = client.id
                                })
                            end
                        })
                    end
                end
            })
            --
        end
    }
}
