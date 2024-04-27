-- Language server installations and LSP client configs and relevant keymaps
return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        local lspconfig = require('lsp-zero')
        lspconfig.preset("recommended")

        lspconfig.ensure_installed({
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
            volar = {},
            terraformls = {}
        })


        lspconfig.configure("bashls", {})
        lspconfig.configure("clangd", {})
        lspconfig.configure("cssls", {})
        lspconfig.configure("docker_compose_language_service", {})
        lspconfig.configure("dockerls", {})
        lspconfig.configure("eslint", {})
        lspconfig.configure("gopls", {
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
        lspconfig.configure("terraformls", {

        })
        lspconfig.configure("html", {})
        lspconfig.configure("lemminx", {})
        lspconfig.configure("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    },
                    workspace = {
                        library = {
                            vim.env.VIMRUNTIME,
                        }
                    }
                }
            }
        })
        lspconfig.configure("marksman", {})
        lspconfig.configure("pyright", {})
        lspconfig.configure("sqlls", {})
        lspconfig.configure("tailwindcss", {})
        lspconfig.configure("tsserver", {})
        lspconfig.configure("yamlls", {})

        local cmp = require('cmp')
        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
            sources = {
                { name = "buffer" },
                { name = "nvim_lsp" },
                { name = "cmp_tabnine" },
                { name = "treesitter" },
                { name = "nvim_lua" },
                { name = "path" },
                { name = "luasnip" },
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
        })
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lspconfig.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        })

        cmp_mappings['<Tab>'] = nil
        cmp_mappings['<S-Tab>'] = nil

        lspconfig.setup_nvim_cmp({
            mapping = cmp_mappings
        })
        lspconfig.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            }
        })

        vim.api.nvim_set_keymap("n", "<leader>dt", ":DapUiToggle<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })
        vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true })
        -- Key bindings to be set after LSP attaches to buffer

        lspconfig.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
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
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
        end)

        lspconfig.setup()
    end
}
