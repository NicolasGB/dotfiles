return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    event = "LspAttach",
    config = function()
      require("tiny-code-action").setup {
        backend = "delta",
        backend_opts = {
          delta = {
            args = {
              "--line-numbers",
              -- "--side-by-side",
            },
          },
        },
        telescope_opts = {
          layout_strategy = "vertical",
          layout_config = {
            width = 0.6,
            height = 0.7,
            preview_cutoff = 1,
            preview_height = function(_, _, max_lines)
              local h = math.floor(max_lines * 0.5)
              return math.max(h, 10)
            end,
          },
        },
      }

      vim.keymap.set({ "n", "v" }, "<A-CR>", function()
        require("tiny-code-action").code_action()
      end, { noremap = true, silent = true })
    end,
  },
}
