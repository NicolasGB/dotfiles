return {
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("fidget").setup {
        -- options
        logger = {
          level = vim.log.levels.INFO,
        },
        progress = {
          lsp = {
            -- this is for rust to finish
            -- https://github.com/j-hui/fidget.nvim/issues/201
            progress_ringbuf_size = 2048, -- Configure the nvim's LSP progress ring buffer size
          },
        },
      }

      -- Hack to close fidget notification when progress is finished
      vim.api.nvim_create_autocmd("LspProgress", {
        pattern = "end",
        callback = function(ev)
          local token = ev.data.params.token
          local client_id = ev.data.client_id
          local client = client_id and vim.lsp.get_client_by_id(client_id)
          if client and token then
            require("fidget").notification.remove(client.name, token)
          end
        end,
      })
    end,
  },
}
