  -- Language server installations and LSP client configs and relevant keymaps
  return {

    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", build = ":MasonUpdate" },
      { "williamboman/mason-lspconfig.nvim" },
      { "ray-x/lsp_signature.nvim" },
    },
    config = function()
        require("mason").setup()
        
        require("mason-lspconfig").setup({
            ensure_installed = {
                  gopls = {},
                  golangci_lint_ls = {},
                  ansiblels = {},
                  arduino_language_server = {},
                  bashls = {},
                  dockerls = {},
                  docker_compose_language_service = {},
                  eslint = {},
                  tsserver = {},
                  lua_ls = {},
                  marksman = {},
                  intelephense = {}, 
                  sqlls = {}, 
                  yamlls = {}
              },
            automatic_installation = false
          })

        local lspconfig = require("lspconfig")

        lspconfig["bashls"].setup({})
        lspconfig["clangd"].setup({})
        lspconfig["cssls"].setup({})
        lspconfig["docker_compose_language_service"].setup({})
        lspconfig["dockerls"].setup({})
        lspconfig["eslint"].setup({})
        lspconfig["gopls"].setup({
          settings = {
            -- https://go.googlesource.com/vscode-go/+/HEAD/docs/settings.md#settings-for
            gopls = {
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true
              },
              experimentalPostfixCompletions = true,
              gofumpt = true,
              -- staticcheck = true,
              --
              -- DISABLED because gopls doesn't invoke the staticcheck binary.
              -- Instead it imports the analyzers directly and this means it can report on issues the binary doesn't.
              -- But rather than that being a good thing, it can be annoying because you can't then use line directives to ignore the issue if it's not important.
              -- So instead I use null-ls to invoke the staticcheck binary.
              -- https://github.com/golang/go/issues/36373#issuecomment-570643870
              --
              -- See also my longer explanation of issues here:
              -- https://github.com/golangci/golangci-lint/issues/741#issuecomment-1488116634
              usePlaceholders = true,
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true
              }
            }
          }
        })
        lspconfig["html"].setup({})
        lspconfig["lemminx"].setup({})
        lspconfig["lua_ls"].setup({})
        lspconfig["marksman"].setup({})
        lspconfig["pyright"].setup({})
        lspconfig["solargraph"].setup({})
        lspconfig["sqlls"].setup({})
        lspconfig["tailwindcss"].setup({})
        lspconfig["tsserver"].setup({})
        lspconfig["yamlls"].setup({})

        -- lsp_signature UI tweaks
        require("lsp_signature").setup({
          bind = true,
          handler_opts = {
            border = "rounded",
          },
        })

        -- LSP hover window UI tweaks
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
          vim.lsp.handlers.hover, {
            border = "single"
          }
        )

        -- LSP diagnostics
        vim.diagnostic.config {
            float = { border = "single" },
            underline = true,
            virtual_text = false,
            virtual_lines = false
        }

        -- Key bindings to be set after LSP attaches to buffer
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspConfig", {}),
          callback = function(ev)
            vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
            vim.api.nvim_buf_set_option(ev.buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")

            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            --vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) SEE telescope.lua
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          end,
        })
    end
  }
