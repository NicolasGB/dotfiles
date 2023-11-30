local opt = vim.opt

-- Line numbers
opt.nu = true
opt.relativenumber = true
opt.cursorline = true


-- Indentationt and formatting
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.wrap = false

-- Undo storing
opt.backup = false
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true   -- Incremental search
opt.ignorecase = false -- Ignore case when searching...
opt.smartcase = true   -- ... unless there is a capital letter in the query

-- Splitting
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true   -- Prefer windows splitting to the right
opt.splitbelow = true   -- Prefer windows splitting to the bottom

opt.termguicolors = true

opt.scrolloff = 10 -- Always show 10 lines below cursor
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

-- Disable color column
opt.colorcolumn = ""

-- Folding
opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all" -- Just turn the dang bell off

-- Remove the 'ro' option from 'formatoptions' to avoid continuing comments
vim.cmd([[
augroup RemoveROFormatOptions
  autocmd!
  autocmd BufNewFile,BufRead * setlocal formatoptions-=ro
augroup END
]])

-- Diagnostic signs instead of letters
local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- Remove background to allow better hover experience
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "NONE" })
