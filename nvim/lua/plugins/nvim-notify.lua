return {
  {
    "rcarriga/nvim-notify",
    config = function()
      local notify = require "notify"
      notify.setup {
        timeout = "2000",
        render = "wrapped-compact",
        stages = "slide",
      }
      vim.notify = notify
    end,
  },
}
