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
  desc = "Use treesitter syntax highlighting for comments with custom injecitons.",
  callback = function(_)
    vim.api.nvim_set_hl(0, "@lsp.type.comment", {})
    vim.api.nvim_set_hl(0, "@lsp.type.string", {})
  end,
})

vim.keymap.set(
  "n",
  "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp { "hover", "actions" }
  end,
  { desc = "Rust hover actions", silent = true, buffer = bufnr }
)

vim.keymap.set("n", "<leader>ll", "<cmd>RustLsp flyCheck<CR>", { desc = "Rust fly check", buffer = true })

vim.keymap.set("ia", "rsx", "rsx! {}<Left>", { desc = "rsx macro abbreviation", buffer = true })
vim.keymap.set("ia", "cls", "||<Left>", { desc = "closure abbreviation", buffer = true })
vim.keymap.set("ia", "mcr", "#[]<Left>", { desc = "macro abbreviation", buffer = true })
