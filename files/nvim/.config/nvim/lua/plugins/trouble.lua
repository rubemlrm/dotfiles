local map = vim.keymap.set
return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
        map("n", "<leader>xx", function() require("trouble").toggle() end, { desc = "Trouble: Toggle UI" })
        map("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end,
            { desc = "Trouble: Workspace diagnostics" })
        map("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end,
            { desc = "Trouble: Document diagnostics" })
        map("n", "<leader>xl", function() require("trouble").open("quickfix") end, { desc = "Trouble: Open quick fix" })
        map("n", "<leader>xq", function() require("trouble").open("loclist") end, { desc = "Trouble: Open Loc list" })
        map("n", "gR", function() require("trouble").open("lsp_references") end,
            { desc = "Trouble: Open LSP references" })
    end,
    config = function()
        require("trouble").setup({})
    end
}
