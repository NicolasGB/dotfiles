require "nicolasgb.remap"
require "nicolasgb.set"

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
  end,
})

-- For nightly neovim which is brokeybroke
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})

-- Remap gf to open files with relative paths in the same window but closing the terminal if it's open
vim.keymap.set("n", "gf", function()
  local line = vim.api.nvim_get_current_line()
  local filename = vim.fn.expand "<cfile>"

  if vim.startswith(filename, "/") and not vim.uv.fs_stat(filename) then
    filename = filename:sub(2)
  end

  if vim.b.toggle_number then
    require("toggleterm").toggle()
  end

  vim.cmd.edit(filename)

  local line, col = line:match(filename .. ":(%d+):?(%d*)")

  if col == "" then
    col = "0"
  end

  vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) })
end)
