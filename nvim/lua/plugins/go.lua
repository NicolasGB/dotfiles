return {
  {
    "fatih/vim-go",
    ft = { "go", "gomod" },
    config = function()
      vim.keymap.set("n", "<leader>fs", ":GoFillStruct<CR>", { desc = "Fill struct" })
      vim.keymap.set("n", "<leader>at", ":GoAddTags json,omitempty<CR>", { desc = "Add tags" })

      --Disable colliding binding
      vim.g.go_def_mapping_enabled = 0

      --Use gopls in fillstruct
      vim.g.go_fillstruct_mode = "gopls"
    end,
  },
}
