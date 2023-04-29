require("scrollbar").setup({
    excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "neo-tree",
        "neo-tree-popup"
    },
    handle = {
        color = "#414B50"
    },
    marks = {
        Search = {
            text = { "━╸" },
            color = "#7FBBB3"
        },
        Error = {
            text = { "━╸" },
            color = "#E67E80"
        },
        Warn = {
            text = { "━╸" },
            color = "#DBBC7F"
        },
    },
    handlers = {
        cursor = false,
        gitsigns = true,
        search = true
    }
})
