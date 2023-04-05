vim.keymap.set("n", "<C-t>", vim.cmd.ToggleTerm)

require("toggleterm").setup({
    size = 15
})
