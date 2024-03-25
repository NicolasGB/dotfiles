return {
    {
        'sbdchd/neoformat',
        ft = { "markdown" },
        config = function()
            vim.api.nvim_create_autocmd("BufEnter", {
                group = vim.api.nvim_create_augroup("buf_enter_neoformat", {
                    clear = true
                }),
                desc = "Autoformat markdown on save",
                callback = function(_)
                    if vim.bo.filetype == "markdown" then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("neoformat_prettier_markdown", {
                                clear = true
                            }),
                            callback = function()
                                vim.api.nvim_command(":Neoformat prettier")
                            end
                        })
                    end
                end
            })
        end,
    }
}
