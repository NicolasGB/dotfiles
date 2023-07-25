return {
    {
        "windwp/nvim-autopairs",
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
                    keys = 'qwertyuiopzxcvbnmasdfghjkl',
                    check_comma = true,
                    manual_position = true,
                    highlight = 'Search',
                    highlight_grey = 'Comment'
                },
                disable_filetype = { "TelescopePrompt", "vim" },
            })

            local ts_conds = require('nvim-autopairs.ts-conds')


            -- press < ton rust files
            npairs.add_rules({
                Rule("<", ">", "rust")
            })
        end
    }
}
