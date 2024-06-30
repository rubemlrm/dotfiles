local map = vim.keymap.set
return {
    "alexghergh/nvim-tmux-navigation",
    config = function()
        require("nvim-tmux-navigation").setup({})
        map("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", {})
        map("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", {})
        map("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", {})
        map("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", {})
    end,
}
