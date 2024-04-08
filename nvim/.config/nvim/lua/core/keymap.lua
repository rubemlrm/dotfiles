local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }
local msg = ""

vim.g.mapleader = " "
-- I can type :help on my own, thanks.
map("", "<F1>","<Esc>",opts)
map("i", "cc", "<Esc>")
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })


-- increment/decrement numbers
map("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- change saving shortcut
map("n", "<c-s>", ":w<CR>")
map("i", "<c-s>", "<Esc>:w<CR>a")

-- change quit shortcut
map("","<leader>q",":quit<CR>", opts) -- Quit current window
map("","<leader>qa",":qa!t<CR>", opts) -- quit all windows

-- bind ctrl movement
map("", "<c-j>", "<c-w>j", opts)
map("","<c-k>", "<c-w>k", opts)
map("","<c-l>", "<c-w>l", opts)
map("","<c-h>", "<c-w>h", opts)

-- map sort function to a key
map("", "<Leader>s", ":sort<CR>", opts)

--  SPLITS

-- Resize vsplit
map("n", "<C-i>", ":vertical resize +5<cr>", opts)
map("n", "<C-d>", ":vertical resize -5<cr>" , opts)
map("n", "<C-r><C-d>", ":resize -5<cr>" , opts)
map("n", "<C-r><C-i>", ":resize +5<cr>" , opts)

-- Open splits
map("n", "<leader>sv", ":vsplit<cr>" , opts)
map("n", "<leader>sh", ":split<cr>" , opts)

-- Create split below
map("n", ":sp",":rightbelow sp<cr>" , opts)

-- BUFFER

-- Quickly go forward or backward to buffer
map("n", "<C->>",":bn<cr>" , opts)
map("n", "<C-<>",":bp<cr>" , opts)

-- switch to last file in buffer
map("n", "<leader><leader>",":b#<cr>" , opts)
--
-- ev Shortcut to edit .vimrc file on the fly on a vertical window.
map("n", "<leader>ev", "<C-w><C-v><C-l>:e $MYVIMRC<cr>", opts)
map("n", "<leader>rv", ":source $MYVIMRC<cr>", opts)

-- space open/closes folds
map("n", "<leader>za", "za", opts)

-- Create/edit file in the current directory
map("n",":ed" ,":edit %:p:h/", opts)
map("n","<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

map('n', '<BS>', msg, { noremap = true, silent = false })

