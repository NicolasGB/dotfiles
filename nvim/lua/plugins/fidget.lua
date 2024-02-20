return {
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
            -- options
            logger = {
                level = vim.log.levels.INFO
            },
            progress = {
                lsp = {
                    -- this is for rust to finish
                    -- https://github.com/j-hui/fidget.nvim/issues/201
                    progress_ringbuf_size = 10000, -- Configure the nvim's LSP progress ring buffer size
                },
            }
        },
    }
}
