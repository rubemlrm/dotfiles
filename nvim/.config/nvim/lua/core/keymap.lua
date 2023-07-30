local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

vim.g.mapleader = " "
-- I can type :help on my own, thanks.
map("", "<F1>","<Esc>",opts)
map("i", "jj", "<Esc>", opts) -- map esc to jj

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
map("n", "<C-v><C-s>", ":vsplit<cr>" , opts)
map("n", "<C-h><C-s>", ":split<cr>" , opts)

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
