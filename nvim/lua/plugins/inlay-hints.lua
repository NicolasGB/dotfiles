return {
    {
        "simrat39/inlay-hints.nvim",
        dependencies = {
            'VonHeikemen/lsp-zero.nvim',
        },
        ft = { "go", "gomod" },
        config = function()
            local ih = require("inlay-hints")
            require("inlay-hints").setup({
                -- renderer to use
                -- possible options are dynamic, eol, virtline and custom
                renderer = "inlay-hints/render/eol",

                hints = {
                    parameter = {
                        show = true,
                        highlight = "Comment",
                    },
                    type = {
                        show = true,
                        highlight = "Comment",
                    },
                },

                -- Only show inlay hints for the current line
                only_current_line = false,

                eol = {
                    -- whether to align to the extreme right or not
                    right_align = false,

                    -- padding from the right if right_align is true
                    right_align_padding = 7,

                    parameter = {
                        separator = ", ",
                        format = function(hints)
                            return string.format(" <- (%s)", hints)
                        end,
                    },

                    type = {
                        separator = ", ",
                        format = function(hints)
                            return string.format(" => (%s)", hints)
                        end,
                    },
                },
            })
            local lspconfig = require("lspconfig")

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
