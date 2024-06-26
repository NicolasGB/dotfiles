local crates = require "crates"
-- Crates plugin
vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Reload crates.nvim", silent = true })

vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Show versions popup", silent = true })
vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Show features popup", silent = true })
vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, { desc = "Show dependencies popup", silent = true })

vim.keymap.set("n", "<leader>cu", crates.update_crate, { desc = "Update crate", silent = true })
vim.keymap.set("v", "<leader>cu", crates.update_crates, { desc = "Update crates", silent = true })
vim.keymap.set("n", "<leader>ca", crates.update_all_crates, { desc = "Update all crates", silent = true })
vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, { desc = "Upgrade crate", silent = true })
vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, { desc = "Upgrade crates", silent = true })
vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, { desc = "Upgrade all crates", silent = true })

vim.keymap.set("n", "<leader>cH", crates.open_homepage, { desc = "Open homepage", silent = true })
vim.keymap.set("n", "<leader>cR", crates.open_repository, { desc = "Open repository", silent = true })
vim.keymap.set("n", "<leader>cD", crates.open_documentation, { desc = "Open documentation", silent = true })
vim.keymap.set("n", "<leader>cC", crates.open_crates_io, { desc = "Open crates.io", silent = true })
