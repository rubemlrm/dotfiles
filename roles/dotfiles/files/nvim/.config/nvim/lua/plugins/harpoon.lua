return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            local map = vim.keymap.set
            harpoon:setup()
            -- basic telescope configuration
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end

            map("n", "<leader>fm", function() toggle_telescope(harpoon:list()) end,
                { desc = "Harpoon: Open harpoon window" })
            map("n", "<leader>aa", function() harpoon:list():add() end, { desc = "Harpoon: Add to list" })
            map("n", "<leader>ss", function() harpoon:list():remove() end, { desc = "Harpoon: Remove from list" })
            map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "Harpoon: Toggle Quick Menu" })
            map("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon: Select 1" })
            map("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon: Select 2" })
            map("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon: Select 3" })
            map("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon: Select 4" })
            map("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end,
                { desc = "Harpoon: Replace markert at position 1" })
            map("n", "<leader><C-t>", function() harpoon:list():replace_at(2) end,
                { desc = "Harpoon: Replace markert at position 2" })
            map("n", "<leader><C-n>", function() harpoon:list():replace_at(3) end,
                { desc = "Harpoon: Replace markert at position 3" })
            map("n", "<leader><C-s>", function() harpoon:list():replace_at(4) end,
                { desc = "Harpoon: Replace markert at position 4" })
        end
    }
}
