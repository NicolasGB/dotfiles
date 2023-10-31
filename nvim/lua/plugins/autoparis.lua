return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require('nvim-autopairs.rule')

            npairs.setup({
                check_ts = true,
                ts_config = {
                    lua = { 'string' }, -- it will not add a pair on that treesitter node
                    javascript = { 'template_string' },
                    java = false,       -- don't check treesitter on java
                },
                enable_check_bracket_line = true,
                fast_wrap = {
                    map = '<A-e>',
                    chars = { '{', '[', '(', '"', "'", "<" },
                    pattern = [=[[%'%"%>%]%)%}%,]]=],
                    end_key = '$',
                    before_key = 'h',
                    after_key = 'l',
                    keys = 'qwertyuiopzxcvbnmasdfghjkl',
                    check_comma = true,
                    manual_position = true,
                    highlight = 'Search',
                    highlight_grey = 'Comment'
                },
                disable_filetype = { "TelescopePrompt", "vim" },
            })

            local ts_conds = require('nvim-autopairs.ts-conds')

            -- If you want to automatically add `(` after selecting a function or method
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            -- press < ton rust files
            npairs.add_rules({
                Rule("<", ">", { "rust", "markdown" })
                    :with_pair(ts_conds.is_not_ts_node({ "comment" }))
            })
        end
    },
    {
        "windwp/nvim-ts-autotag",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require 'nvim-treesitter.configs'.setup {
                autotag = {
                    enable = true,
                }
            }
        end
    }
}
