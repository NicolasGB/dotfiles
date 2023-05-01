return {
    {
        "neanias/everforest-nvim",
        config = function()
            require("everforest").setup({
                background = "hard",
            })

            vim.cmd.colorscheme "everforest"
        end,
        lazy = false,
        priority = 1,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato", -- latte, frappe, macchiato, mocha
                background = {
                    -- :h background
                    light = "mocha",
                    dark = "macchiato",
                },
                transparent_background = false,
                show_end_of_buffer = false, -- show the '~' characters after the end of buffers
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.90,
                },
                no_italic = false, -- Force no italic
                no_bold = false,   -- Force no bold
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                color_overrides = {},
                custom_highlights = {},
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    notify = false,
                    mini = false,
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
            })
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                --- @usage 'auto'|'main'|'moon'|'dawn'
                variant = 'moon',
                --- @usage 'main'|'moon'|'dawn'
                dark_variant = 'main',
                bold_vert_split = false,
                dim_nc_background = false,
                disable_background = false,
                disable_float_background = false,
                disable_italics = false,

                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups = {
                    background = 'base',
                    background_nc = '_experimental_nc',
                    panel = 'surface',
                    panel_nc = 'base',
                    border = 'highlight_med',
                    comment = 'muted',
                    link = 'iris',
                    punctuation = 'subtle',

                    error = 'love',
                    hint = 'iris',
                    info = 'foam',
                    warn = 'gold',

                    headings = {
                        h1 = 'iris',
                        h2 = 'foam',
                        h3 = 'rose',
                        h4 = 'gold',
                        h5 = 'pine',
                        h6 = 'foam',
                    }
                    -- or set all headings at once
                    -- headings = 'subtle'
                },

                -- Change specific vim highlight groups
                -- https://github.com/rose-pine/neovim/wiki/Recipes
                highlight_groups = {
                    ColorColumn = { bg = 'rose' },

                    -- Blend colours against the "base" background
                    CursorLine = { bg = 'foam', blend = 10 },
                    StatusLine = { fg = 'love', bg = 'love', blend = 10 },
                }
            })
        end
    },
    { "rmehri01/onenord.nvim", branch = 'main' },
    {
        "marko-cerovac/material.nvim",
        name = "material",
        config = function()
            vim.g.material_style = "palenight"

            require('material').setup({
                contrast = {
                    terminal = false,            -- Enable contrast for the built-in terminal
                    sidebars = false,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
                    floating_windows = false,    -- Enable contrast for floating windows
                    cursor_line = false,         -- Enable darker background for the cursor line
                    non_current_windows = false, -- Enable darker background for non-current windows
                    filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
                },

                styles = {
                    -- Give comments style such as bold, italic, underline etc.
                    comments = { --[[ italic = true ]] },
                    strings = { --[[ bold = true ]] },
                    keywords = { --[[ underline = true ]] },
                    functions = { --[[ bold = true, undercurl = true ]] },
                    variables = {},
                    operators = {},
                    types = {},
                },

                plugins = { -- Uncomment the plugins that you use to highlight them
                    -- Available plugins:
                    -- "dap",
                    -- "dashboard",
                    "gitsigns",
                    -- "hop",
                    -- "indent-blankline",
                    -- "lspsaga",
                    -- "mini",
                    -- "neogit",
                    -- "neorg",
                    -- "nvim-cmp",
                    -- "nvim-navic",
                    -- "nvim-tree",
                    -- "nvim-web-devicons",
                    -- "sneak",
                    "telescope",
                    -- "trouble",
                    -- "which-key",
                },

                disable = {
                    colored_cursor = false, -- Disable the colored cursor
                    borders = false,        -- Disable borders between verticaly split windows
                    background = false,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
                    term_colors = false,    -- Prevent the theme from setting terminal colors
                    eob_lines = false       -- Hide the end-of-buffer lines
                },

                high_visibility = {
                    lighter = false, -- Enable higher contrast text for lighter style
                    darker = false   -- Enable higher contrast text for darker style
                },

                lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

                async_loading = true,      -- Load parts of the theme asyncronously for faster startup (turned on by default)

                custom_colors = nil,       -- If you want to everride the default colors, set this to a function

                custom_highlights = {},    -- Overwrite highlights with your own
            })
        end
    }
}
