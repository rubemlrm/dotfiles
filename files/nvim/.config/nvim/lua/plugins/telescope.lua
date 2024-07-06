local map = vim.keymap.set
return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = function()
        local builtin = require("telescope.builtin")
        map("n", "<leader>th", builtin.oldfiles, {})
        map("n", "<leader>tt", function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end,
            {})
        map('n', '<leader>fr', builtin.registers, { desc = "Telescope: Search registers"})
        map("n", "<leader>fc", builtin.git_files, { desc = "Telescope: Search git files" })
        map("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Find files" })
        map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Grep Files" })
        map("n", "<leader>fs", builtin.grep_string, { desc = "Telescope: Grep String" })
        map("n", "<leader>fb", builtin.buffers, { desc = "Telescope: List buffers" })
        map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Help Tags" })
        map("n", "<leader>fx", builtin.treesitter, { desc = "Telescrope: Search treesitter" })
        map("n", "<leader>fd", builtin.diagnostics, { desc = "Telescope: Search diagnostics" })
        map("n", "<leader>fgs", builtin.git_status, { desc = "Telescope: Preview git status" })
        map("n", "<leader>fe", ":Telescope file_browser<CR>", { desc = "Telescope: File Browser" })
        map("n", "<leader>fgr", ":Telescope repo list<CR>", { desc = "Telescope: Repo list" })
        map("n", "<leader>fk", builtin.keymaps, { desc = "Telescope: Search keymaps" })
        map({ "n", "x" }, "<leader>frr", function() require("telescope").extensions.refactoring.refactors() end,
            { desc = "Telescope: Refactoring Actions" })
    end,
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" },
        "nvim-telescope/telescope-project.nvim",
        "cljoly/telescope-repo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-dap.nvim"
    },
    config = function()
        local actions = require "telescope.actions"
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

        require("telescope").setup {
            defaults = {
                buffer_previewer_maker = new_maker,
                layout_strategy = "flex",
                sorting_strategy = "ascending",
                selection_strategy = "closest",
                file_ignore_patterns = { "node_modules", "vendor", "site-packages" },
                mappings = {
                    n = {
                        ["<c-d>"] = actions.delete_buffer,
                    },
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        ["<C-h>"] = actions.which_key,
                        ["<C-u>"] = false,
                        ["<c-d>"] = actions.delete_buffer,
                        ["<C-s>"] = actions.cycle_previewers_next,
                        ["<C-a>"] = actions.cycle_previewers_prev,

                    }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {
                        additional_args = function()
                            return { "--hidden", "--glob", "!**/.git/*" }
                        end,
                    },
                    grep_string = {
                        additional_args = function()
                            return { "--hidden", "--glob", "!**/.git/*" }
                        end,
                    },
                },
                extensions = {
                    file_browser = {
                        hidden = { file_browser = true, folder_browser = true },
                        hijack_netrw = true,
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
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
                    project = {}
                }
            } }
        require("telescope").load_extension("refactoring")
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("repo")
        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("dap")
    end
}
