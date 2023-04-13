require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({paths = {"./custom-snippets"}})

local luasnip = require("luasnip")

luasnip.config.setup({
})

