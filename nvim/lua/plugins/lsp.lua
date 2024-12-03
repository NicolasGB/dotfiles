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

      -- Signature
      -- { "ray-x/lsp_signature.nvim" },

      -- Telescope
      { "nvim-telescope/telescope.nvim" },

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

          -- Go to definition
          vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
          -- Go to type definition
          vim.keymap.set("n", "gt", telescope.lsp_type_definitions, opts)
          -- Go to declaration
          vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
          -- Hover
          vim.keymap.set("n", "K", function() vim.lsp.buf.hover({border = "rounded"}) end, opts)

          -- View diagnostics
          vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)

          -- Go to next error
          vim.keymap.set("n", "ge", function() vim.diagnostic.jump({count = 1}) end, opts)

          -- Go to previous error
          vim.keymap.set("n", "gpe", function() vim.diagnostic.jump({count = -1}) end, opts)
          -- List errors with telescope
          vim.keymap.set("n", "<leader>le", telescope.diagnostics, opts)

          -- View references
          vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)

          -- Rename
          vim.keymap.set("n", "<leader>R", function() vim.lsp.buf.rename() end, opts)

          -- Signature help
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help({border = "rounded"}) end, opts)

          -- Get references
          vim.keymap.set("n", "gr", function() telescope.lsp_references { include_declaration = false } end, opts)

          vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
          -- stylua: ignore end
        end,
      })

      -- Lsp Signature Helper
      -- local _ = require("lsp_signature").setup {
      --   floating_window = false,
      --   hint_prefix = {
      --     above = "↙ ", -- when the hint is on the line above the current line
      --     current = "← ", -- when the hint is on the same line
      --     below = "↖ ", -- when the hint is on the line below the current line
      --   },
      -- }

      -- LspConfig
      local lspconfig = require "lspconfig"
      local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Lsp Default setup
      local default_setup = function(server)
        -- Register given lsp default capabilities
        lspconfig[server].setup {
          capabilities = lsp_capabilities,
        }
      end

      require("mason").setup {}
      require("mason-lspconfig").setup {
        ensure_installed = { "gopls", "lua_ls", "yamlls", "jsonls", "taplo", "typos_lsp" },
        handlers = {
          default_setup,
          -- Lua setup
          lua_ls = function()
            lspconfig.lua_ls.setup {
              on_attach = function(_, b)
                vim.lsp.inlay_hint.enable(true, { bufnr = b })
              end,
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
            }
          end,
          -- YAML setup
          yamlls = function()
            lspconfig.yamlls.setup {
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
            }
          end,
          -- GraphQL setup
          graphql = function()
            local util = require "lspconfig.util"
            lspconfig.graphql.setup {
              root_dir = util.root_pattern(
                ".git",
                ".graphqlrc*",
                ".graphql.config.*",
                "graphql.config.*",
                "/config/gqlgen.yaml"
              ),
            }
          end,
          -- Golang setup
          gopls = function()
            lspconfig.gopls.setup {
              on_attach = function(_, b)
                vim.lsp.inlay_hint.enable(true, { bufnr = b })
              end,
              settings = {
                gopls = {
                  directoryFilters = { "-**/graph/generated", "-**/node_modules" },
                  experimentalPostfixCompletions = true,
                  analyses = {
                    unusedparams = true,
                    unusedresult = true,
                    shadow = true,
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
                },
              },
            }
          end,
          -- TS Server setup
          ts_ls = function()
            require("lspconfig").ts_ls.setup {
              on_attach = function(_, b)
                vim.lsp.inlay_hint.enable(true, { bufnr = b })
              end,
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
            }
          end,
          typos_lsp = function()
            require("lspconfig").typos_lsp.setup {
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
            }
          end,
          cucumber_language_server = function()
            -- We just want formatting since cucumber needs the source code sadly
            require("lspconfig").cucumber_language_server.setup {
              on_init = function(client, _)
                client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
              end,
              handlers = {
                ["textDocument/publishDiagnostics"] = function() end,
              },
            }
          end,
        },
      }

      -- Nushell (not in mason)
      lspconfig.nushell.setup {}

      -- nukleus
      -- require("lspconfig.configs").nukleus = {
      --   default_config = {
      --     cmd = { "/home/nicolas/dev/work/nukleus-lsp/target/debug/nukleus-lsp" },
      --     filetypes = { "go" },
      --     root_dir = lspconfig.util.root_pattern "go.mod",
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
