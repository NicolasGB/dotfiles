return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" }, -- Required

      -- Signature
      { "ray-x/lsp_signature.nvim" },

      -- Telescope
      { "nvim-telescope/telescope.nvim" },

      -- Neodev for vim api lsp
      { "folke/neodev.nvim" },
      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema store
      "b0o/schemastore.nvim",
    },
    config = function()
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
      -- Set Borders on hovers
      local border_style = "rounded"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border_style })

      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers["signature_help"], { border = border_style })

      -- Diagnostics
      vim.diagnostic.config {
        virtual_text = {
          prefix = "●",
        },
        -- update_in_insert = true,
        underline = true,
        severity_sort = true,

        float = {
          severity_sort = true,
          header = "Diagnostics",
          source = "if_many",
          prefix = "• ",

          border = "rounded",
        },
        signs = {
          -- Set nice text signs
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      }

      -- LspConfig
      local lspconfig = require "lspconfig"
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

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
          vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

          -- View diagnostics
          vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)

          -- Go to next error
          vim.keymap.set("n", "ge", function() vim.diagnostic.jump({count = 1}) end, opts)

          -- Go to previous error
          vim.keymap.set("n", "gpe", function() vim.diagnostic.jump({count = -1}) end, opts)
          -- List errors with telescope
          vim.keymap.set("n", "<leader>le", telescope.diagnostics, opts)

          -- Good old JetBrains
          -- vim.keymap.set("n", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)
          -- vim.keymap.set("v", "<A-CR>", function() vim.lsp.buf.code_action() end, opts)

          -- View references
          vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)

          -- Rename
          vim.keymap.set("n", "<leader>R", function() vim.lsp.buf.rename() end, opts)

          -- Signature help
          vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

          -- Get references
          vim.keymap.set("n", "gr", function() telescope.lsp_references { include_declaration = false } end, opts)

          vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
          -- stylua: ignore end
        end,
      })

      -- Lsp Signature Helper
      local _ = require("lsp_signature").setup {
        floating_window = false,
        hint_prefix = {
          above = "↙ ", -- when the hint is on the line above the current line
          current = "← ", -- when the hint is on the same line
          below = "↖ ", -- when the hint is on the line below the current line
        },
      }

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
                  diagnostics = {
                    globals = { "vim" },
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
          tsserver = function()
            require("lspconfig").tsserver.setup {
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
        },
      }

      -- Nushell (not in mason)
      require("lspconfig").nushell.setup {}

      -- Autoformatting with conform
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          markdown = { "prettier" },
        },
        format_on_save = function(bufnr)
          return { lsp_format = "fallback", quiet = true, bufnr = bufnr }
        end,
      }
    end,
  },
}
