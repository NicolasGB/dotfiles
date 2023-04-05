vim.cmd("hi HopNextKey guifg=#18dede")
vim.cmd("hi HopNextKey1 guifg=#18dede")
vim.cmd("hi HopNextKey2 guifg=#18dede")

local hop = require("hop")
local directions = require('hop.hint').HintDirection

hop.setup({})


vim.keymap.set('', 'f', function()
  hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})
