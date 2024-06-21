return {
    {
        "rmagatti/auto-session",
        config = function()
            vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
            vim.keymap.set('n', '<leader>p', require('auto-session.session-lens').search_session)
            require('auto-session').setup {
                pre_save_cmds = { 'Neotree close' },
                post_restore_cmds = { 'Neotree filesystem show' },
            }
        end,
    }
}
