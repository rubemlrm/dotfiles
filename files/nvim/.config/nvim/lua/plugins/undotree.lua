local map = vim.keymap.set
return {
    {
        "mbbill/undotree",
        config = function()
            map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree: toggle history" })
        end
    },
}
