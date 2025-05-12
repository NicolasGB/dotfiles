return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "saghen/blink.cmp" },
      { "L3MON4D3/LuaSnip" }, -- Required

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema store
      "b0o/schemastore.nvim",
    },
    config = function()
      -- On LSP attach setup telescope mappings with lsp actions
      local telescope = require "telescope.builtin"
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keybindings", { clear = true }),
        desc = "LSP actions",
        callback = function(event)
          -- stylua: ignore start
          local opts = { buffer = event.buf }
          -- Hover
          -- Avoid setting it on rust files since its managed by rustanalyzer
          if vim.bo.filetype ~= "rust" then
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover({border = "rounded"}) end, opts)
          end

          -- View diagnostics
          vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)

          -- Go to next error
          vim.keymap.set("n", "ge", function() vim.diagnostic.jump({count = 1}) end, opts)
          vim.keymap.set("n", "<C-e>", function() vim.diagnostic.jump({count = 1}) end, opts)

          -- Go to previous error
          vim.keymap.set("n", "gpe", function() vim.diagnostic.jump({count = -1}) end, opts)

          -- View references
          vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)

          -- Rename
          vim.keymap.set("n", "<leader>R", function() vim.lsp.buf.rename() end, opts)

          -- Signature help
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help({border = "rounded"}) end, opts)

          -- stylua: ignore end
        end,
      })

      -- LspConfig
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local on_attach = function(_, b)
        vim.lsp.inlay_hint.enable(true, { bufnr = b })
      end

      -- Setup mason and enable automatically the lsp installed by them
      require("mason").setup {}
      require("mason-lspconfig").setup {
        ensure_installed = { "gopls", "lua_ls", "yamlls", "jsonls", "taplo", "typos_lsp" },
        automatic_enable = true,
      }

      -- Setup lua
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
            },
            hint = {
              enable = true,
            },
          },
        },
      })
      -- Setup go
      vim.lsp.config("gopls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            directoryFilters = { "-**/graph/generated", "-**/node_modules" },
            experimentalPostfixCompletions = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            analyses = {
              ST1003 = false,
              fieldalignment = false,
              fillreturns = true,
              nilness = true,
              nonewvars = true,
              shadow = true,
              undeclaredname = true,
              unreachable = true,
              unusedparams = true,
              unusedresult = true,
              unusedwrite = true,
              useany = true,
            },
            staticcheck = true,
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            gofumpt = true,
            semanticTokens = false,
          },
        },
      })

      -- Setup yamlls
      vim.lsp.config("yamlls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
            keyOrdering = false,
          },
        },
      })

      -- Setup graphql
      local util = require "lspconfig.util"
      vim.lsp.config("graphql", {
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = util.root_pattern(
          ".git",
          ".graphqlrc*",
          ".graphql.config.*",
          "graphql.config.*",
          "/config/gqlgen.yaml"
        ),
      })

      -- Setup ts_ls
      vim.lsp.config("ts_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            importModuleSpecifierPreference = "non-relative",
          },
        },
        single_file_support = true,
        root_dir = require("lspconfig.util").root_pattern "package.json",
      })

      -- Setup typos
      vim.lsp.config("typos_lsp", {
        on_attach = on_attach,
        capabilities = capabilities,
        config = {
          -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
          cmd_env = { RUST_LOG = "ERROR" },
        },
        init_options = {
          -- Custom config. Used together with any workspace config files, taking precedence for
          -- settings declared in both. Equivalent to the typos `--config` cli argument.
          -- config = '~/code/typos-lsp/crates/typos-lsp/tests/typos.toml',
          -- How typos are rendered in the editor, eg: as errors, warnings, information, or hints.
          -- Defaults to error.
          diagnosticSeverity = "Information",
        },
        single_file_support = true,
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("typos.toml", "_typos.toml", ".typos.toml")(fname)
            or vim.fn.getcwd()
        end,
        filetypes = {
          "go",
          "gomod",
          "gowork",
          "rust",
          "yaml",
          "toml",
          "cucumber",
          "graphql",
          "markdown",
          "lua",
          "ts",
          ".",
          "proto",
        },
      })

      -- Setup cucumber
      vim.lsp.config("cucumber_language_server", {
        on_attach = on_attach,
        capabilities = capabilities,
        on_init = function(client, _)
          client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
        end,
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
      })

      -- Setup html
      vim.lsp.config("html", {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "htmlangular", "html", "templ" },
      })

      -- Setup nushell
      vim.lsp.config("nushell", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- nukleus
      -- require("lspconfig.configs").nukleus = {
      --   default_config = {
      --     cmd = { "/home/nicolas/dev/work/nukleus-lsp/target/debug/nukleus-lsp" },
      --     filetypes = { "yaml" },
      --     root_dir = lspconfig.util.find_git_ancestor,
      --     -- root_dir = lspconfig.util.root_pattern "go.mod",
      --     settings = {},
      --   },
      -- }
      -- lspconfig.nukleus.setup {}

      -- Autoformatting with conform
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          markdown = { "prettier" },
          go = {
            "goimports",
            "gofumpt",
          },
        },
        format_on_save = function(bufnr)
          return { lsp_format = "fallback", quiet = true, bufnr = bufnr }
        end,
      }
    end,
  },
}
