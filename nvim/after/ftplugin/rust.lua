-- Open cargo
vim.keymap.set('n', '<leader>oc', function() vim.cmd.RustLsp('openCargo') end, { desc = "Open Cargo.toml" })

-- Clear fidget as it bugs often
vim.keymap.set("n", "<leader>cl", function() vim.cmd.Fidget("clear") end, { desc = "Clear fidget spinner" })
