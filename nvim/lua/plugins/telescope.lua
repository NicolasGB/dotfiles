return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        -- or                              , branch = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            -- "nvim-telescope/telescope-frecency.nvim",
        },
        config = function()
            local builtin = require('telescope.builtin')
            -- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>ff', function()
                builtin.find_files({
                    hidden = true,
                    find_command = { '/usr/bin/fd', "-H", '--type', 'f', '-I', '-E', '.git', '-E', '.idea' }
                })
            end, { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>gr', builtin.live_grep, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            -- Search in help
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

            local actions = require("telescope.actions")
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                            -- even more opts
                        }
                    }
                },
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<esc>"] = actions.close,
                            ["<A-c>"] = actions.delete_buffer,
                        },
                        n = {
                            ["<esc>"] = actions.close,
                            ["<A-c>"] = actions.delete_buffer,
                        }
                    },
                }
            }

            require("telescope").load_extension("ui-select")
            -- require("telescope").load_extension("frecency")
        end
    },
}
