return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local function getTelescopeOpts(state, path)
            return {
                cwd = path,
                search_dirs = { path },
                attach_mappings = function(prompt_bufnr, map)
                    local actions = require "telescope.actions"
                    actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local action_state = require "telescope.actions.state"
                        local selection = action_state.get_selected_entry()
                        local filename = selection.filename
                        if (filename == nil) then
                            filename = selection[1]
                        end
                        -- any way to open the file without triggering auto-close event of neo-tree?
                        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
                    end)
                    return true
                end
            }
        end


        require("neo-tree").setup({
            filesystem = {
                window = {
                    mappings = {
                        ["ff"] = "telescope_find",
                        ["gr"] = "telescope_grep",
                    }
                },
                commands = {
                    telescope_find = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        require('telescope.builtin').find_files(getTelescopeOpts(state, path))
                    end,
                    telescope_grep = function(state)
                        local node = state.tree:get_node()
                        local path = node:get_id()
                        require('telescope.builtin').live_grep(getTelescopeOpts(state, path))
                    end,
                },

                filtered_items = {
                    visible = false,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    always_show = {
                        ".gitignore",
                        ".gitlab-ci.yml",
                        "target",
                        "Cargo.lock",
                        ".env",
                        ".ssh",
                        ".shared",

                        -- Kore
                        ".env.local",
                        "docker-compose.override.yaml"

                    },
                },
                follow_current_file = {
                    enabled = true,         -- This will find and focus the file in the active buffer every time
                    --               -- the current file is changed while the tree is open.
                    leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(file_path)
                        --auto close
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },
            },
        })
    end
}
