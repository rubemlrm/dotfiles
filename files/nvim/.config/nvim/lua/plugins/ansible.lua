local map = vim.keymap.set
return {
    {
        "mfussenegger/nvim-ansible",
        config = function()
            map('v', '<leader>te', function() require('ansible').run() end, { buffer = true, silent = true })
            map('n', '<leader>te', ":w<CR> :lua require('ansible').run()<CR>", { buffer = true, silent = true })
        end
    }
}
