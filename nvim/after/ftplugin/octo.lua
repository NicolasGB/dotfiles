-- In octo i want to force close the buffer
vim.keymap.set("n", "<A-c>", ":BufferClose!<CR>", { desc = "Octo force close buffer", buffer = true })
