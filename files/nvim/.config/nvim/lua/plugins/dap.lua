return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function ()

            require("mason").setup()
            require("mason-nvim-dap").setup({
                ensure_installed = { "python", "delve" }
            })
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                floating = {
                    max_height = nil,
                    max_width = nil,
                    border = "single",
                    mappings = {
                      close = { "q", "<Esc>" },
                    },
                },
                layouts = {
                    {
                      elements = {
                        "scopes",
                      },
                      size = 0.2,
                      position = "bottom"
                    },
                    {
                      elements = {
                        "repl",
                        "breakpoints"
                      },
                      size = 0.2,
                      position = "left",
                    },
                }
            })

            -- enable out of the box config with dap go
            require('dap-go').setup()
            local map = vim.keymap.set

            dap.adapters.ansible = {
              type = "executable",
              command = "python", -- or "/path/to/virtualenv/bin/python",
              args = { "-m", "ansibug", "dap" },
            }

            local ansibug_configurations = {
              {
                type = "ansible",
                request = "launch",
                name = "Debug playbook",
                playbook = "${file}"
              },
            }

            dap.configurations["yaml.ansible"] = ansibug_configurations

            -- autoload vscode debug configurations 
            require('dap.ext.vscode').load_launchjs(nil, {})

            -- load UI on debug 
            dap.listeners.before.attach.dapui_config = function()
			dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
            vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
            vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})
            map('n', '<leader>dh', dapui.eval)
            map('n', '<leader>du', ":DapUiToggle<CR>", { noremap = true })
            map('n', '<leader>dc', dap.continue)
            map('n', '<leader>do', dap.step_over)
            map('n', '<leader>di', dap.step_into)
            map('n', '<leader>dx', dap.step_out)
            map('n', '<leader>dt', dap.toggle_breakpoint)
            map('n', '<leader>de', dap.terminate)
        end
    }
}
