local map = vim.keymap.set
return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function ()
            map("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", { desc = "MarkdownPreview: Preview Toggle" } )
        end
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        main = "render-markdown",
        opts = {},
        name = 'render-markdown',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    }
}

