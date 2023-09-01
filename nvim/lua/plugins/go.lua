return {
    -- {
    --     "ray-x/go.nvim",
    --     dependencies = { -- optional packages
    --         "ray-x/guihua.lua",
    --         "neovim/nvim-lspconfig",
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    --     ft = { "go", "gomod" },
    --     build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    --     config = function()
    --         require("go").setup({
    --             disable_defaults = true
    --
    --         })
    --
    --         -- Run goimports on save
    --         local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
    --         vim.api.nvim_create_autocmd("BufWritePre", {
    --             pattern = "*.go",
    --             callback = function()
    --                 require('go.format').goimport()
    --             end,
    --             group = format_sync_grp,
    --         })
    --
    --         vim.keymap.set("n", "<leader>fs", ":GoFillStruct<CR>")
    --         vim.keymap.set("n", "<leader>at", ":GoAddTag<CR>")
    --     end,
    -- },
    {
        "fatih/vim-go",
        ft = { "go", "gomod" },
        config = function()
            vim.keymap.set("n", "<leader>fs", ":GoFillStruct<CR>")
            vim.keymap.set("n", "<leader>at", ":GoAddTags json,omitempty<CR>")

            --Disable colliding binding
            vim.g.go_def_mapping_enabled = 0

            --Use gopls in fillstruct
            vim.g.go_fillstruct_mode = "gopls"
        end
    }
}
