return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-path',
            "onsails/lspkind.nvim",
        },
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Replace }
            local cmp_mappings = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            })

            --- Luasnip Mapping ---
            local luasnip = require("luasnip")
            cmp_mappings["<Tab>"] = cmp.mapping(function(fallback)
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { "i", "s" })
            cmp_mappings["<S-Tab>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" })

            --- CMP Setup ---
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = "nvim_lsp" },
                    {
                        name = "luasnip",
                        option = { use_show_condition = false, show_autosnippets = true }
                    },
                    { name = "buffer" },
                    { name = "path" },
                },
                mapping = cmp_mappings,
                preselect = 'none',
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                -- Disable completion in comments
                enabled = function()
                    -- Check if the current buffer's filetype is "TelescopePrompt"
                    local telescope_prompt = vim.bo.filetype == "TelescopePrompt"

                    -- Check if the cursor is inside a comment (treesitter or syntax).
                    local inside_comment = require("cmp.config.context").in_treesitter_capture("comment") == true
                        or require("cmp.config.context").in_syntax_group("Comment")

                    return not (telescope_prompt or inside_comment)
                end,
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                performance = {
                    debounce = 300,
                    throttle = 60,
                    fetching_timeout = 200,
                },
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 100,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snip]",
                        })
                    })
                }
            })
        end
    }
}
