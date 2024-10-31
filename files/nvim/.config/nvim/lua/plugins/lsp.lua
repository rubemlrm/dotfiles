local map = vim.keymap.set
return {
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            local lspconfig = require("lsp-zero")
            require("mason").setup({})

            require("mason-tool-installer").setup({
                ensure_installed = {
                    "goimports",
                    "golangci-lint",
                    "gotests",
                    "gofumpt",
                    "golines",
                    "gomodifytags",
                    "tflint",
                    "tfsec",
                    "stylua",
                    "json-to-struct",
                    "misspell",
                    "shellcheck",
                    "ansible-lint",
                    "lua-language-server",
                    "editorconfig-checker",
                    "fixjson",
                    "markdown-toc",
                    "markdownlint-cli2",
                    "autopep8",
                }
            })

            require("mason-lspconfig").setup({
                -- Replace the language servers listed here
                -- with the ones you want to install
                ensure_installed = {
                    "gopls",
                    "golangci_lint_ls",
                    "arduino_language_server",
                    "dockerls",
                    "docker_compose_language_service",
                    "eslint",
                    "marksman",
                    "intelephense",
                    "sqls",
                    "yamlls",
                    "ansiblels",
                    "bashls",
                    "html",
                    "tsserver",
                    "lua_ls",
                    "tailwindcss",
                    "volar",
                    "terraformls",
                    "ansiblels",
                    "templ",
                    "tsserver",
                    "cssls",
                    "eslint",
                    "ltex",
                    "helm_ls",
                    "ansible-lint",
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                    marksman = function()
                        local opts = {}
                        require("lspconfig").marksman.setup(opts)
                    end,
                    eslint = function()
                        local opts = {
                            settings = {
                                workingDirectories = { mode = "auto" },
                            }
                        }
                        require("lspconfig").eslint.setup(opts)
                    end,
                    ltex = function()
                        local opts = {
                            cmd = { "ltex-ls" },
                            -- filetypes = { "markdown", "text" },
                            -- flags = { debounce_text_changes = 300 },
                            settings = {
                                ltex =  {
                                    enabled = { "latex", "tex", "bib", "markdown" },
                                    language = "en",
                                    diagnosticSeverity = "information",
                                    setenceCacheSize = 2000,
                                    additionalRules = {
                                        enablePickyRules = true,
                                        motherTongue = "en",
                                    },
                                    trace = { server = "verbose" },
                                    dictionary = {},
                                    disabledRules = {},
                                    hiddenFalsePositives = {},
                                }
                            }
                        }
                        require("lspconfig").ltex.setup(opts)
                    end,
                    gopls = function()
                        local opts = {
                            settings = {
                                gopls = {
                                    analyses = {
                                        nilness = true,
                                        unusedparams = true,
                                        unusedwrite = true,
                                        useany = true
                                    },
                                    experimentalPostfixCompletions = true,
                                    gofumpt = true,
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
                        }
                        require("lspconfig").gopls.setup(opts)
                    end,
                    lua_ls = function()
                        local opts = {
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" }
                                    },
                                    workspace = {
                                        library = {
                                            vim.env.VIMRUNTIME,
                                        }
                                    }
                                }
                            }
                        }
                        require("lspconfig").lua_ls.setup(opts)
                    end
                }
            })

            local cmp = require("cmp")
            local cmp_action = require("lsp-zero").cmp_action()
            local cmp_format = lspconfig.cmp_format()
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
                formatting = cmp_format,
                preselect = "item",
                window = {
                    documentation = cmp.config.window.bordered(),
                    completion = cmp.config.window.bordered(),
                },
                completion = {
                    completeopt = "menu,menuone,noinsert"
                },
                sources = {
                    { name = "buffer",     keyword_length = 2 },
                    { name = "nvim_lsp" },
                    { name = "cmp_tabnine" },
                    { name = "treesitter" },
                    { name = "nvim_lua" },
                    { name = "path" },
                    { name = "luasnip",    keyword_length = 2 },
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp_action.tab_complete(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp_action.tab_complete()
                })
            })

            -- Key bindings to be set after LSP attaches to buffer

            lspconfig.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                local lspbuf = vim.lsp.buf
                local lspdiagnostic = vim.diagnostic
                map("n", "gi", function() lspbuf.implementation() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Go to implementation" })
                map("n", "gs", function() lspbuf.signature_help() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Get Signature Help" })
                map("n", "gd", function() lspbuf.definition() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Go to definition" })
                map("n", "K", function() lspbuf.hover() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Get hover description" })
                map("n", "<leader>vws", function() lspbuf.workspace_symbol() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Get workspace symbol" })
                map("n", "<leader>vd", function() lspdiagnostic.open_float() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Open diagnostics on float window" })
                map("n", "[d", function() lspdiagnostic.jump({ count = 1 }) end,
                    { buffer = bufnr, remap = false, desc = "LSP: Go to next diagnostic" })
                map("n", "]d", function() lspdiagnostic.jump({ count = -1 }) end,
                    { buffer = bufnr, remap = false, desc = "LSP: Go to previous diagnotisc" })
                map("n", "<leader>vca", function() lspbuf.code_action() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Toggle Actions" })
                map("n", "<leader>vrr", function() lspbuf.references() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Get References" })
                map("n", "<leader>vrn", function() lspbuf.rename() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Rename" })
                map("i", "<C-h>", function() lspbuf.signature_help() end,
                    { buffer = bufnr, remap = false, desc = "LSP: Show signature help" })
                map("n", "<leader>f", lspbuf.format, { buffer = bufnr, remap = false, desc = "LSP: Format document" })
            end)

            lspconfig.set_sign_icons({
                error = "✘",
                warn = "▲",
                hint = "⚑",
                info = ""
            })

            vim.diagnostic.config({
                virtual_text = true,
            })

            lspconfig.setup()
        end
    },
}
