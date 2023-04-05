vim.keymap.set("n", "<A-,>", vim.cmd.BufferPrevious)
vim.keymap.set("n", "<A-.>", vim.cmd.BufferNext)

vim.keymap.set("n", "<A-c>", vim.cmd.BufferClose)

vim.keymap.set("n", "<leader>bc", vim.cmd.BufferCloseAllButCurrent)

vim.keymap.set("n", "<C-b>", vim.cmd.BufferPick)

