return {
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>vs", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      preview_window = {
        auto_preview = true,
        width = 40,
      },
      -- Your setup opts here
      outline_window = {
        wrpa = true,
        width = 30,
        auto_close = true,
      },
    },
  },
}
