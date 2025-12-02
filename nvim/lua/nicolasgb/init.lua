require "nicolasgb.remap"
require "nicolasgb.set"
require "nicolasgb.snips.init"

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Highlight selection on yank",
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "IncSearch", { fg = "#282c34", bg = "#a7c080" })
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
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

-- Reload files when externally modified
vim.api.nvim_create_autocmd({
  "FocusGained",
  "BufEnter", --[[ "CursorHold", "CursorHoldI" ]]
}, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd "checktime"
    end
  end,
})

-- When spliting the smae file deactivate cursorline for inactive buffer
-- Enable cursor for buffer
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})
-- Disable cursor for buffer
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = "active_cursorline",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
