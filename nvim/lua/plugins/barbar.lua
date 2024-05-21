return {
    {
        "romgrk/barbar.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            -- lazy.nvim can automatically call setup for you. just put your options here:
            -- insert_at_start = true,
            -- animation = true,
            -- …etc
        },
        branch = "master",
        config = function()
            local filetreename = "neo-tree"
            local function get_filetree_window()
                for _, windowId in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                    local buffer = vim.api.nvim_win_get_buf(windowId)
                    if vim.api.nvim_buf_get_option(buffer, "ft") == filetreename then
                        return windowId
                    end
                end
                return nil
            end

            local function get_filetree_width()
                local windowId = get_filetree_window()
                if windowId == nil then
                    return
                end
                return vim.fn.winwidth(windowId)
            end

            vim.api.nvim_create_autocmd({ "BufWinEnter", "WinScrolled", "BufWinLeave", "BufWipeout" }, {
                callback = function()
                    local width = get_filetree_width()

                    require("bufferline.api").set_offset(width or 0)
                end,
            })

            --Keymaps
            vim.keymap.set("n", "<A-,>", vim.cmd.BufferPrevious)
            vim.keymap.set("n", "<A-.>", vim.cmd.BufferNext)

            vim.keymap.set("n", "<A-c>", vim.cmd.BufferClose)

            vim.keymap.set("n", "<leader>bc", vim.cmd.BufferCloseAllButCurrent)

            vim.keymap.set("n", "<C-b>", vim.cmd.BufferPick)
        end,
    },
}
