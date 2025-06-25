-- Move code up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Move lines up and keep cursor at the beginning
vim.keymap.set("n", "J", "mzJ`z")

-- Keymap for duplicating a line
-- vim.api.nvim_set_keymap('n', '<leader>m', [[:t.<CR>]], { noremap = true, silent = true })

-- Fast moving
vim.keymap.set("n", "<c-h>", "<c-w><c-h>")
vim.keymap.set("n", "<c-j>", "<c-w><c-j>")
vim.keymap.set("n", "<c-k>", "<c-w><c-k>")
vim.keymap.set("n", "<c-l>", "<c-w><c-l>")

-- Moving to occurrences with centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste and do not lose yanked values
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Format file through lsp
vim.keymap.set("n", "<A-l>", vim.lsp.buf.format)

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Pasting up and down
vim.keymap.set("n", "<leader>pu", ":1pu!<CR>")

-- Replace word
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Saving the old way
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>^V")

-- Quitting
vim.keymap.set("n", "<C-q>", ":qa<CR>")
vim.keymap.set("i", "<C-q>", "<Esc>:qa<CR>")
vim.keymap.set("v", "<C-q>", "<Esc>:qa<CR>")

-- New lines
vim.api.nvim_set_keymap("n", "<Leader>J", "o<Esc>k", { noremap = true, silent = true, desc = "Add new line on bottom" })
vim.api.nvim_set_keymap("n", "<Leader>k", "O<Esc>j", { noremap = true, silent = true, desc = "Add new line on top" })

-- Select all
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

-- Indentation
vim.api.nvim_set_keymap("v", ">", ">gv", { desc = "Indent right" })
vim.api.nvim_set_keymap("v", "<", "<gv", { desc = "Indent left" })

-- NoOp
vim.keymap.set("n", "Q", "<nop>")

-- Pasting the old way in insert mode
vim.api.nvim_set_keymap("i", "<C-v>", '<C-r>"', { desc = "Paste in insert mode" })

-- Remove highlight
vim.api.nvim_set_keymap("n", "<leader>h", ":noh<CR>", { desc = "Remove highlight from search" })

-- CR to split braces
vim.keymap.set("n", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local prev_char = line:sub(col, col)
  local current_char = line:sub(col + 1, col + 1)

  if prev_char == "{" and current_char == "}" then
    local indent = string.rep(" ", vim.fn.indent(vim.fn.line "."))
    local before_brace = line:sub(1, col - 1)
    local after_brace = line:sub(col + 2)
    local current_line_num = vim.fn.line "." - 1
    local new_lines = {
      before_brace .. "{",
      indent .. "    ",
      indent .. "}" .. after_brace,
    }
    vim.api.nvim_buf_set_lines(0, current_line_num, current_line_num + 1, false, new_lines)
    -- Move cursor to the middle line
    vim.api.nvim_win_set_cursor(0, { current_line_num + 2, #indent + 4 })
    vim.cmd "startinsert"
  else
    -- Normal <CR> behavior
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", false)
  end
end, { desc = "Split {} into multiple lines, or normal behavior" })
