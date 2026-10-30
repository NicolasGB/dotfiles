return {
  {
    "petertriho/nvim-scrollbar",
    -- TODO: remove after 2026-11-16, when v2 lands on main
    branch = "refactor/v2",
    config = function()
      require("scrollbar").setup {
        exclude = {
          -- A list replaces the plugin defaults (same as v1)
          filetypes = {
            "prompt",
            "TelescopePrompt",
            "noice",
            "neo-tree",
            "neo-tree-popup",
          },
          -- No scrollbar inside codediff tabs: its floats get re-rendered
          -- while codediff runs :tabclose, which then fails with E445.
          when = function(ctx)
            local ok, lifecycle = pcall(require, "codediff.ui.lifecycle")
            if not ok then
              return false
            end
            local tab = vim.api.nvim_win_get_tabpage(ctx.winid)
            return lifecycle.get_session(tab) ~= nil
          end,
        },
        providers = {
          cursor = false,
          gitsigns = false,
          search = false,
          marks = false, -- new in v2, off to match v1
        },
        marks = {
          Search = {
            text = { "━╸" },
            highlight = { fg = "#7FBBB3" },
          },
          Error = {
            text = { "━╸" },
            highlight = { fg = "#E67E80" },
          },
          Warn = {
            text = { "━╸" },
            highlight = { fg = "#DBBC7F" },
          },
          Info = {
            text = { "━╸" },
          },
          Hint = {
            text = { "━╸" },
          },
          Misc = {
            text = { "━╸" },
          },
        },
        scrollbar = {
          -- v1 had no track; drop it from the default layout
          layout = {
            columns = {
              { "thumb", "marks" },
            },
          },
          thumb = {
            highlight = { bg = "#414B50" },
          },
        },
      }
    end,
  },
}
