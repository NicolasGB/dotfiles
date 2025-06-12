return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "folke/snacks.nvim" },
    },
    event = "LspAttach",
    config = function()
      require("tiny-code-action").setup {
        picker = {
          "snacks",
          opts = {
            layout = {
              layout = {
                backdrop = false,
                width = 0.5,
                min_width = 80,
                height = 0.8,
                min_height = 30,
                box = "vertical",
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
                { win = "preview", title = "{preview}", height = 0.6, border = "top" },
              },
            },
          },
        },
        backend = "delta",
        backend_opts = {
          delta = {
            args = {
              "--line-numbers",
              -- "--side-by-side",
            },
          },
        },
      }

      vim.keymap.set({ "n", "v" }, "<A-CR>", function()
        require("tiny-code-action").code_action {}
      end, { noremap = true, silent = true })
    end,
  },
}
