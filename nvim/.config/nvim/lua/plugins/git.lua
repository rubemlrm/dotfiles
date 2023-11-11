local map = vim.keymap.set
return {
    {"tpope/vim-fugitive", lazy = false },
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
        map('n', '<leader>,', ':LazyGit<CR>', {})
       end,
    },
}
