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
            vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
            vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
        end,
    },
    -- Icons
    { 'nvim-tree/nvim-web-devicons', lazy = false },
    { "nvim-neotest/nvim-nio" },
    -- Dashboard (start screen)
    {
      'goolord/alpha-nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- Autopair
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = function()
        require('nvim-autopairs').setup{}
      end
    },
    {
      "ThePrimeagen/refactoring.nvim",
      dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("refactoring").setup()
      end,
   },
   {
     "numToStr/Comment.nvim",
      config = function ()
        require('Comment').setup()
      end
   },
   {"github/copilot.vim"},
   {"gpanders/editorconfig.nvim"},
   {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        presets = {
            command_palette = true,
            long_message_to_split = true,
            lsp_doc_border = true,
        },
      },
      dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
        }
   },
   {
     'rmagatti/auto-session',
     config = function()
      require("auto-session").setup {
      log_level = "error",
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_root_dir = os.getenv("HOME") .. "/.vim_temp/sessions",
      pre_save_cmds = {},
      save_extra_cmds = {},
      post_restore_cmds = {},
      cwd_change_handling = {
        restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
        pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
      },
    }
     end
   },
   {
    "mbbill/undotree",
    config = function() 
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
   },
   {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 15; -- Height of the floating window
        border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}; -- Border characters of the floating window
        default_mappings = true;
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
        };
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true; -- Focus the floating window when opening it.
        dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether
      }
    end
  },
}
