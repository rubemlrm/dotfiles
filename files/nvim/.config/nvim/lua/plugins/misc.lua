return {
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
            vim.keymap.set(
                { "n", "x" },
                "<leader>rr",
                function() require('refactoring').select_refactor() end
            )
        end,
    },
    { "gpanders/editorconfig.nvim" },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        'goolord/alpha-nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require 'alpha'.setup(require 'alpha.themes.theta'.config)
        end
    },
}
