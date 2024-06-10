local map = vim.keymap.set
return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        init = function()
            map('n', '<leader>gs', vim.cmd.Git,{})
            map('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', {})
            map('n', '<leader>gt', ':Gitsigns toggle_current_line_blame<CR>', {})
        end,

    },
    {
      'lewis6991/gitsigns.nvim',
      lazy = true,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        require('gitsigns').setup{}
      end
    },
    {
      "kdheepak/lazygit.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
      },
      init = function()
        map('n', '<leader>lg', ':LazyGit<CR>', {})
       end,
    },
}
