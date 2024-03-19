return {
    {
      'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'lewis6991/gitsigns.nvim',
      },
      config = function()
        require('lualine').setup({
           options = {
            icons_enabled = true,
            component_separators = '|',
            section_separators = '',
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {
              {'branch', 'diff', 'diagnostics'}
            },
            lualine_c = {'buffers'}

          }}
        )
      end
    },
}
