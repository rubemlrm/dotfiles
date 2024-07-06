local map = vim.keymap.set

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            { "mxsdev/nvim-dap-vscode-js" },
            { "microsoft/vscode-js-debug", build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" }
        },
        config = function()
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
            require("dap-go").setup()

            dap.adapters.ansible = {
                type = "executable",
                command = "python",
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

            local js_languages = {
                "typescript",
                "javascript",
                "typescriptreact",
                "javascriptreact",
                "vue",
                "node"
            }
            require("dap.ext.vscode").load_launchjs(nil, {})

            require("dap-vscode-js").setup({
                node_path = "node",
                debugger_path = vim.fn.resolve(vim.fn.stdpath("data")) .. "/lazy/vscode-js-debug",
            })

            for _, language in ipairs(js_languages) do
                dap.configurations[language] = {

                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require "dap.utils".pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Debug Jest Tests",
                        -- trace = true, -- include debugger info
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "./node_modules/jest/bin/jest.js",
                            "--runInBand",
                        },
                        rootPath = "${workspaceFolder}",
                        cwd = "${workspaceFolder}",
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                    },
                    {
                        name = "---- launch.json configs ----",
                        type = "",
                        request = "launch",
                    }
                }
            end

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
            vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
            map("n", "<leader>dh", dapui.eval, { desc = "Debug: Evalute values" })
            map("n", "<leader>du", ":DapUiToggle<CR>", { noremap = true, desc = "Debug: Toogle UI" })
            map("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
            map("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
            map("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
            map("n", "<leader>dx", dap.step_out, { desc = "Debug: Step Out" })
            map("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            map("n", "<leader>de", dap.terminate, { desc = "Debug: Terminate" })
        end
    }
}
