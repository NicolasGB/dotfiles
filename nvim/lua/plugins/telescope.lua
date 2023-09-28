return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        -- or                              , branch = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>gr', builtin.live_grep, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, {})
            -- Search in help
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }
                    }
                }
            }

            require("telescope").load_extension("ui-select")

            local actions = require("telescope.actions")
            require("telescope").setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<esc>"] = actions.close,
                        },
                    },
                }
            }
        end
    },
}
