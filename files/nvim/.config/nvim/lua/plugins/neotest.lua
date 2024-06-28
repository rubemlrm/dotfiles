local map = vim.keymap.set
return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "marilari88/neotest-vitest",
            "nvim-neotest/neotest-plenary",
            "nvim-neotest/neotest-go",
            "nvim-neotest/neotest-jest"
        },
        config = function()
            local neotest = require("neotest")
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
              virtual_text = {
                format = function(diagnostic)
                  local message =
                    diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                  return message
                end,
              },
            }, neotest_ns)
            neotest.setup({
                adapters = {
                    require("neotest-vitest"),
                    require("neotest-jest"),
                    require("neotest-go")({
                        {
                            experimental = {
                                test_table = true,
                            },
                            recursive_run = true
                        }
                    })
                }
            })
            map("n", "<leader>ts", function()
                neotest.summary.toggle()
            end)
            map("n", "<leader>tc", function()
                neotest.run.run()
            end)
            map("n", "<leader>td", function()
                neotest.run.run(vim.fn.getcwd())
            end)
            map("n", "<leader>tf", function()
                neotest.run.run(vim.fn.expand("%"))
            end)
        end,
    },
}
