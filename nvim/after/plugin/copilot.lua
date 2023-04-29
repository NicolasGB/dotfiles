vim.g.copilot_filetypes = { markdown = true, yaml = true }
vim.g.copilot_no_tab_map = true

vim.api.nvim_set_keymap("i", "<A-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
