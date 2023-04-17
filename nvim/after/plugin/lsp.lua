vim.diagnostic.config({
    virtual_text = true,
})

local lsp = require("lsp-zero").preset({})

lsp.ensure_installed({
    "rust_analyzer",
    "gopls",
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.replace }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

--- Luasnip Mapping ---
local luasnip = require("luasnip")
cmp_mappings["<Tab>"] = cmp.mapping(function(fallback)
    if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
end, { "i", "s" })
cmp_mappings["<S-Tab>"] = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end, { "i", "s" })

--- CMP Setup ---
lsp.setup_nvim_cmp({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    sources = {
        { name = "luasnip", option = { use_show_condition = false, show_autosnippets = true } },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "crates" }
    },
    mapping = cmp_mappings,
    preselect = 'first',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
})

-- Disable completion in comments
cmp.setup({
    enabled = function()
        if require "cmp.config.context".in_treesitter_capture("comment") == true or require "cmp.config.context".in_syntax_group("Comment") then
            return false
        else
            return true
        end
    end
})

-- some lsp settings

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    },
})

--Telescope for some shortcuts
local telescope = require("telescope.builtin")

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "ge", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "gpe", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>le", telescope.diagnostics, opts)
    -- Good old JetBrains 
    vim.keymap.set("n", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("v", "<leader>va", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>R", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "gr", telescope.lsp_references, opts)
    vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
    vim.keymap.set("n", "<leader>vs", function() telescope.lsp_document_symbols({ symbol_width = 80 }) end, opts)
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
require("lspconfig").gopls.setup({
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
})


lsp.skip_server_setup({ "rust_analyzer" })

lsp.setup()

