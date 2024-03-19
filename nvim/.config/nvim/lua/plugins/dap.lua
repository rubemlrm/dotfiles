  -- Language server installations and LSP client configs and relevant keymaps
  return {

    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", build = ":MasonUpdate" },
      { "williamboman/mason-lspconfig.nvim" },
      { "ray-x/lsp_signature.nvim" },
    },
    opts = {
          capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
    },
    config = function()
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                  gopls = {},
                  golangci_lint_ls = {},
                  arduino_language_server = {},
                  dockerls = {},
                  docker_compose_language_service = {},
                  eslint = {},
                  marksman = {},
                  intelephense = {},
                  sqlls = {},
                  yamlls = {},
                  ansiblels = {},
                  bashls = {},
                  html = {},
                  tsserver = {},
                  lua_ls = {},
                  tailwindcss = {},
                  volar = {}
              },
            automatic_installation = true
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
        lspconfig["lua_ls"].setup({
              settings = {
                  Lua = {
                      diagnostics = {
                          globals = {'vim'}
                      },
                      workspace = {
                          library = {
                              vim.env.VIMRUNTIME, 
                          }
                      }
                  }
              }
          })
        lspconfig["marksman"].setup({})
        lspconfig["pyright"].setup({})
        lspconfig["sqlls"].setup({})
        lspconfig["tailwindcss"].setup({})
        lspconfig["tsserver"].setup({})
        lspconfig["yamlls"].setup({})

        -- lsp_signature UI tweaks
        -- require("lsp_signature").setup({
        --  bind = true,
        --  handler_opts = {
        --    border = "rounded",
        --  },
        -- })

        -- LSP hover window UI tweaks
        -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        -- vim.lsp.handlers.hover, {
        --    border = "single"
        -- }
        -- )

        -- LSP diagnostics
        vim.diagnostic.config {
            float = { border = "single" },
            underline = true,
            virtual_text = false,
            virtual_lines = false
        }
        vim.api.nvim_set_keymap("n", "<leader>dt", ":DapUiToggle<CR>", {noremap=true})
        vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
        vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
        vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", {noremap=true})
        vim.api.nvim_set_keymap("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", {noremap=true})
        vim.api.nvim_set_keymap("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {noremap=true})
        -- Key bindings to be set after LSP attaches to buffer

        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspConfig", {}),
          callback = function(ev)
            vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
            vim.api.nvim_buf_set_option(ev.buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
          end,
          })
    end
  }
