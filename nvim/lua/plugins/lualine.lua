return {
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            -- Get current working directory
            local function cwd()
                local c = vim.fn.getcwd()
                if c == nil then
                    return ''
                end

                -- Split and get last
                local cwd_parts = vim.split(c, '/')

                return "../" .. cwd_parts[#cwd_parts - 1] .. "/" .. cwd_parts[#cwd_parts]
            end

            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = { 'filename', },
                    lualine_x = { cwd, 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress', },
                    lualine_z = { 'location' }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
}
