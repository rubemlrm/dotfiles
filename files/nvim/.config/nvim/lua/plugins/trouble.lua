local map = vim.keymap.set
return {
 "folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 init = function()
    map("n", "<leader>xx", function() require("trouble").toggle() end)
    map("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
    map("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
    map("n", "<leader>xl", function() require("trouble").open("quickfix") end)
    map("n", "<leader>xq", function() require("trouble").open("loclist") end)
    map("n", "gR", function() require("trouble").open("lsp_references") end)
 end,
 config = function()
    require("trouble").setup({})
 end
}

