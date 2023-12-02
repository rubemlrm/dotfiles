local map = vim.keymap.set
return {
  'nvim-telescope/telescope.nvim',
  cmd = "Telescope",
  init = function()
      local builtin = require('telescope.builtin')
      map('n', '<leader>th', builtin.oldfiles, {})
      map('n', '<leader>tt', function()
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end, 
      {})
      map('n', '<leader>ff', builtin.find_files, {})
      map('n', '<leader>fg', builtin.live_grep, {})
      map('n', '<leader>fb', builtin.buffers, {})
      map('n', '<leader>fh', builtin.help_tags, {})
      map('n', '<leader>fx', builtin.treesitter, {})
      map('n', '<leader>fd', builtin.diagnostics, {})
      map('n', '<leader>fr', builtin.git_status, {})
      map('n', '<leader>fe', ':Telescope file_browser<CR>', {})
      map('n', '<leader>fm', ':Telescope harpoon marks<CR>', {})
  end,
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    'ThePrimeagen/harpoon',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
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
    local telescopeConfig = require("telescope.config")

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    require('telescope').setup {
      defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
            find_files = {
                -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
        },
        extensions = {
                file_browser = {
                    hijack_netrw = true,
                    hidden = true
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",    
                },
                repo = {
                  list = {
                    fd_opts = {
                      "--no-ignore-vcs",
                    },
                    search_dirs = {
                      "~/Works/Code",
                    },
                  },
                },
               project =  {}
            }
    }
  pcall(require('telescope').load_extension, 'fzf')
  require('telescope').load_extension('repo')
  require('telescope').load_extension('project')
  require('telescope').load_extension('file_browser')
  end
}
