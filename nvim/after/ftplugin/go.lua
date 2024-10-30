vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "Golang non nil err" })

vim.keymap.set(
  "ia",
  "gerr",
  "if err != nil {<CR>}<Esc>Oreturn err<Esc>",
  { desc = "Golang non nil err abbr", buffer = true }
)

vim.keymap.set("ia", "gco", "ctx context.Context,", { desc = "Golang context func parameter", buffer = true })

vim.keymap.set("n", "<space>dt", function()
  require("dap-go").debug_test()
end, { buffer = 0, desc = "debug test" })
