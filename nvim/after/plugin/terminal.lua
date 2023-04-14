require("toggleterm").setup({
    size = 15,
    open_mapping = [[<C-t>]],
    direction = "float",
})

-- Lazy docker terminal
local Terminal  = require('toggleterm.terminal').Terminal
local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

function _lazydocker_toggle()
  lazydocker:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>ld", "<cmd>lua _lazydocker_toggle()<CR>", {noremap = true, silent = true})
