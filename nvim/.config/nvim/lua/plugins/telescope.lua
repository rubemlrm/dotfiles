local map = vim.keymap.set
return {
  'nvim-telescope/telescope.nvim',
  cmd = "Telescope",
  init = function()
      local builtin = require('telescope.builtin')
      map('n', '<leader>ff', builtin.find_files, {})
      map('n', '<leader>fg', builtin.live_grep, {})
      map('n', '<leader>fb', builtin.buffers, {})
      map('n', '<leader>fh', builtin.help_tags, {})
      map('n', '<leader>fx', builtin.treesitter, {})
  end,
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    "nvim-telescope/telescope-project.nvim",
    "cljoly/telescope-repo.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup {}
      end,
    },
  },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup {
      defaults = {
        find_command = {
          'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case', '--files', '--follow', '--glob', '!.git'
        }
      }
    }
  end
}
