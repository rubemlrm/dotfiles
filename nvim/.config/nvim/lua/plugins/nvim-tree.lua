local map = vim.keymap.set
return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  version =  "v1.3",
  lazy = false,
  module = true,
  init = function()
      map("n", "<leader>nt", ":NvimTreeToggle<CR>", { silent = false })
      map("n", "<leader>nf", ":NvimTreeFindFile<CR>", { silent = true })
  end,
  cmd = {
    "NvimTreeOpen",
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
  },
  tag = 'nightly', -- optional, updated every week. (see issue #1193)
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true
    vim.g.nvim_tree_width = 25
    vim.g.nvim_tree_gitignore = 1
    vim.g.nvim_tree_indent_markers = 1

    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      filters = {
        custom = { ".git$", ".pyc$", "__pycache__" },
      },
      hijack_directories = { enable = true, auto_open = false }
    })
  end
}
