vim.keymap.set("n", "<leader>pv", vim.cmd.Neotree)

-- Move code up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Move lines up and keep cursor at the beginning
vim.keymap.set("n", "J", "mzJ`z")

-- When searching keep cursor middle and jump to middle page up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste and do not lose yanked values
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Format file through lsp
vim.keymap.set("n", "<A-l>", vim.lsp.buf.format)

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Replace word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Saving the old way
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>^V")

-- Quitting
vim.keymap.set("n", "<C-q>", ":qa<CR>")
vim.keymap.set("i", "<C-q>", "<Esc>:qa<CR>")
vim.keymap.set("v", "<C-q>", "<Esc>:qa<CR>")
