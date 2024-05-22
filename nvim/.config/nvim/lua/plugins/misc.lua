local map = vim.keymap.set
return {
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
   {"github/copilot.vim"},
   {"gpanders/editorconfig.nvim"},
}
