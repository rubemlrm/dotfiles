local map = vim.keymap.set 
return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            map("n", "<C-n>", ":Neotree filesystem toggle left<CR>", {})
            map("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false
                    }
                }
            })
        end,
    },

}
