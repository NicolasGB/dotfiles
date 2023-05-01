return {
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
        config = function()
            vim.keymap.set("n", "<leader>md", vim.cmd.MarkdownPreview)
        end
    }
}
