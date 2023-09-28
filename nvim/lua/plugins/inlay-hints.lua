return {
    -- {
    --     "simrat39/inlay-hints.nvim",
    --     dependencies = {
    --         'VonHeikemen/lsp-zero.nvim',
    --     },
    --     ft = { "go", "gomod" },
    --     config = function()
    --         local ih = require("inlay-hints")
    --         require("inlay-hints").setup({
    --             -- renderer to use
    --             -- possible options are dynamic, eol, virtline and custom
    --             renderer = "inlay-hints/render/eol",
    --
    --             hints = {
    --                 parameter = {
    --                     show = true,
    --                     highlight = "Comment",
    --                 },
    --                 type = {
    --                     show = true,
    --                     highlight = "Comment",
    --                 },
    --             },
    --
    --             -- Only show inlay hints for the current line
    --             only_current_line = false,
    --
    --             eol = {
    --                 -- whether to align to the extreme right or not
    --                 right_align = false,
    --
    --                 -- padding from the right if right_align is true
    --                 right_align_padding = 7,
    --
    --                 parameter = {
    --                     separator = ", ",
    --                     format = function(hints)
    --                         return string.format(" <- (%s)", hints)
    --                     end,
    --                 },
    --
    --                 type = {
    --                     separator = ", ",
    --                     format = function(hints)
    --                         return string.format(" => (%s)", hints)
    --                     end,
    --                 },
    --             },
    --         })
    --         local lspconfig = require("lspconfig")
    --
    --         -- Golang setup
    --
    --         lspconfig.gopls.setup({
    --             on_attach = function(c, b)
    --                 ih.on_attach(c, b)
    --             end,
    --             settings = {
    --                 gopls = {
    --                     experimentalPostfixCompletions = true,
    --                     analyses = {
    --                         unusedparams = true,
    --                         unusedresult = true,
    --                         shadow = true,
    --                     },
    --                     staticcheck = true,
    --                     hints = {
    --                         assignVariableTypes = true,
    --                         compositeLiteralFields = true,
    --                         compositeLiteralTypes = true,
    --                         constantValues = true,
    --                         functionTypeParameters = true,
    --                         parameterNames = false,
    --                         rangeVariableTypes = true,
    --                     },
    --                 },
    --             },
    --         })
    --     end
    -- }
    {
        "lvimuser/lsp-inlayhints.nvim",
        dependencies = {
            'VonHeikemen/lsp-zero.nvim',
        },
        ft = { "go", "gomod", "lua" },
        config = function()
            local ih = require("lsp-inlayhints")
            require("lsp-inlayhints").setup({
                inlay_hints = {
                    parameter_hints = {
                        show = true,
                        prefix = "<- ",
                        separator = ", ",
                        remove_colon_start = false,
                        remove_colon_end = true,
                    },
                    type_hints = {
                        -- type and other hints
                        show = true,
                        prefix = "=> ",
                        separator = ", ",
                        remove_colon_start = false,
                        remove_colon_end = false,
                    },
                    only_current_line = false,
                    -- separator between types and parameter hints. Note that type hints are
                    -- shown before parameter
                    labels_separator = "  ",
                    -- whether to align to the length of the longest line in the file
                    max_len_align = false,
                    -- padding from the left if max_len_align is true
                    max_len_align_padding = 1,
                    -- highlight group
                    highlight = "Comment", -- This can be set to 'LspInlayHint'
                    -- virt_text priority
                    priority = 0,
                },
                enabled_at_startup = true,
                debug_mode = false,
            })
            local lspconfig = require("lspconfig")


            -- Lua setup
            require('lspconfig').lua_ls.setup({
                on_attach = function(client, bufnr)
                    ih.on_attach(client, bufnr)
                end,
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        hint = {
                            enable = true,
                        },
                    },
                },
            })


            -- Golang setup
            lspconfig.gopls.setup({
                on_attach = function(c, b)
                    ih.on_attach(c, b)
                end,
                settings = {
                    gopls = {
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
                            parameterNames = false,
                            rangeVariableTypes = true,
                        },
                    },
                },
            })
        end
    }
}
