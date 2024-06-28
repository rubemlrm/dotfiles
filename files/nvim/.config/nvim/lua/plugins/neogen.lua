local map = vim.keymap.set
return {
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local neogen = require("neogen")
        local dap = require("dap")

        neogen.setup({
            snippet_engine = "luasnip"
        })

        map("n", "<leader>nf", function()
            neogen.generate({ type = "func" })
        end)

        map("n", "<leader>nt", function()
            neogen.generate({ type = "type" })
        end)
    end
}
