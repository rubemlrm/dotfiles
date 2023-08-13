local map = vim.keymap.set
return {
    -- Icons
    { 'nvim-tree/nvim-web-devicons', lazy = false },

    -- Dashboard (start screen)
    {
      'goolord/alpha-nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    -- Git labels
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
    -- Statusline
    {
      'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
      },
      config = function()
        require('lualine').setup()
      end
    },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },


    -- Tag viewer
    { 'preservim/tagbar' },

    -- Autopair
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup{}
      end
    },
    {
      "kdheepak/lazygit.nvim",
      dependencies = {
         "nvim-lua/plenary.nvim",
      },
      init = function() 
        map('n', '<leader>0', ':LazyGit<CR>', {})
       end,
    },
    {'akinsho/toggleterm.nvim', version = "*", config = true},
    -- lazy.nvim
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
      }
    }
}
