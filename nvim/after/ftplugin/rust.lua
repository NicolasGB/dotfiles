-- Open cargo
vim.keymap.set("n", "<leader>oc", function()
  vim.cmd.RustLsp "openCargo"
end, { desc = "Open Cargo.toml" })

-- Clear fidget as it bugs often
vim.keymap.set("n", "<leader>cl", function()
  vim.cmd.Fidget "clear"
end, { desc = "Clear fidget spinner" })

-- When using injections and this kinds of things if the server can return semantic tokens, treesitter highlihgting is killed
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Use treesitter syntax highlihgting for comments with custom injecitons.",
  callback = function(args)
    vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
    vim.api.nvim_set_hl(0, "@lsp.type.string", {})
  end,
})
