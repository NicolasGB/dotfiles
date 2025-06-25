return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      -- Kestrel prod
      -- {
      --   "tree-sitter-kestrel",
      --   url = "git@github.com:kestrel-rs/treesitter-kes.git",
      --   branch = "main",
      --   init = function()
      --     vim.g.kestrel_parser_url = "~/.local/share/nvim/lazy/tree-sitter-kestrel/"
      --   end,
      -- },

      -- Kestrel dev
      -- {
      --   "tree-sitter-kestrel",
      --   dir = "~/dev/kestrel-rs/treesitter-kes",
      --   branch = "main",
      --   init = function()
      --     vim.g.kestrel_parser_url = "~/dev/kestrel-rs/treesitter-kes"
      --   end,
      -- },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "lua", "go", "rust", "toml", "yaml", "markdown_inline", "json", "nu" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,
          -- Seems bugged currently
          disable = { "dockerfile" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = false,
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["gna"] = "@parameter.inner", -- Jump to next argument
              ["gnf"] = "@function.outer", -- Jump to next function
            },
            goto_previous_start = {
              ["gpa"] = "@parameter.inner", -- Jump to previous argument
              ["gpf"] = "@function.outer", -- Jump to previous function
            },
          },

          lsp_interop = {
            enable = true,
            border = "rounded",
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>vf"] = "@function.outer",
              ["<leader>vF"] = "@class.outer",
            },
          },
        },
      }

      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
      require("treesitter-context").setup {}

      -- Color TreeSitter context based on the mode
      local function set_tree_sitter_context_colors()
        if vim.o.background == "dark" then
          -- vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#1B2228" })
          vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#272E33" })
        else
          vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#D3D5D0" })
        end
      end

      -- Set colors initially
      set_tree_sitter_context_colors()

      -- Create an autocommand to update colors when the colorscheme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("TreeSitterContextColors", { clear = true }),
        callback = set_tree_sitter_context_colors,
      })
    end,
  },
}
