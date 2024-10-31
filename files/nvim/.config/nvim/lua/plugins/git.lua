local map = vim.keymap.set
return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        init = function()
            map("n", "<leader>gs", vim.cmd.Git, { desc = "Fugitive: Show changes" })
        end,

    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("gitsigns").setup {}
            map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "GitSigns: Preview Hunk" })
            map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>",
                { desc = "GitSigns: Toggle Blame for line" })
        end
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            map("n", "<leader>lg", ":LazyGit<CR>", { desc = "Lazygit: Toggle UI" })
        end,
    },
    {
      'topaxi/gh-actions.nvim',
      keys = {
        { '<leader>gh', '<cmd>GhActions<cr>', desc = 'Open Github Actions' },
      },
      -- optional, you can also install and use `yq` instead.
      build = 'make',
      opts = {},
    },
    {
      'git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git',
      -- Activate when a file is created/opened
      event = { 'BufReadPre', 'BufNewFile' },
      -- Activate when a supported filetype is open
      ft = { 'go', 'javascript', 'python', 'ruby' },
      opts = {
        statusline = {
          -- Hook into the built-in statusline to indicate the status
          -- of the GitLab Duo Code Suggestions integration
          enabled = true,
        },
      },
    }
}
