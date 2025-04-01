local map = vim.keymap.set
return {
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local neogen = require("neogen")

        neogen.setup({
            snippet_engine = "luasnip"
        })
        map("n", "<leader>nf", function() neogen.generate({ type = "func" }) end,
            { desc = "Neogen: Create function annotations" })
        map("n", "<leader>nt", function() neogen.generate({ type = "type" }) end,
            { desc = "Neogen: Create type annotations" })
    end
}
