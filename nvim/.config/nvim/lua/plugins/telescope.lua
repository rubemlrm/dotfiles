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
      map('n', '<leader>fc', builtin.git_files, {})
      map('n', '<leader>ff', builtin.find_files, {})
      map('n', '<leader>fg', builtin.live_grep, {})
      map('n', '<leader>fs', builtin.grep_string, {})
      map('n', '<leader>fb', builtin.buffers, {})
      map('n', '<leader>fh', builtin.help_tags, {})
      map('n', '<leader>fx', builtin.treesitter, {})
      map('n', '<leader>fd', builtin.diagnostics, {})
      map('n', '<leader>fr', builtin.git_status, {})
      map('n', '<leader>fts', builtin.treesitter, {})
      map('n', '<leader>fe', ':Telescope file_browser<CR>', {})
      map('n', '<leader>fr', ':Telescope repo list<CR>', {})
      map('n', '<leader>fk', builtin.keymaps, {})
  end,
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
    "nvim-telescope/telescope-project.nvim",
    "cljoly/telescope-repo.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  config = function() 

    local telescopeConfig = require("telescope.config")
    local actions = require "telescope.actions" 
    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    -- Dont Preview Binaries
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")
    local new_maker = function(filepath, bufnr, opts)
      filepath = vim.fn.expand(filepath)
      Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]
          if mime_type == "text" then
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          else
            -- maybe we want to write something to the buffer here
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
            end)
          end
        end
      }):sync()
    end

    require('telescope').setup {
      defaults = {
        buffer_previewer_maker = new_maker,
        layout_strategy = 'flex',
		sorting_strategy = 'ascending',
		selection_strategy = 'closest',
		file_ignore_patterns = { 'node_modules', 'vendor', 'site-packages' },
        vimgrep_arguments = vimgrep_arguments,
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = actions.which_key,
            ["<C-u>"] = false,
            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            ["<C-s>"] = actions.cycle_previewers_next,
            ["<C-a>"] = actions.cycle_previewers_prev,

          }
        },
        extensions = {
                file_browser = {
                    hijack_netrw = true,
                    hidden = true,
                    mappings = {

                        }
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
    }}
  pcall(require('telescope').load_extension, 'fzf')
  require('telescope').load_extension('repo')
  require('telescope').load_extension('file_browser')
  end
}
