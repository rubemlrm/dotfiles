local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }
local msg = ""

vim.g.mapleader = " "
-- I can type :help on my own, thanks.
map("", "<F1>", "<Esc>", opts)
map("i", "cc", "<Esc>")
map("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "Exit insert mode with jk" })

map("n", "<leader>nh", ":nohl<CR>", { noremap = true, silent = true, desc = "Clear search highlights" })


-- increment/decrement numbers
map("n", "<leader>+", "<C-a>", { noremap = true, silent = true, desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { noremap = true, silent = true, desc = "Decrement number" }) -- decrement

-- change saving shortcut
map("n", "<c-s>", ":w<CR>", { noremap = true, silent = true, desc = "Changed save to ctrl+s" })
map("i", "<c-s>", "<Esc>:w<CR>a", { noremap = true, silent = true, desc = "Changed save to ctrl+s" })

-- change quit shortcut
map("", "<leader>q", ":quit<CR>", { noremap = true, silent = true, desc = "Changed quit to leader+q" })       -- Quit current window
map("", "<leader>qa", ":qa!t<CR>", { noremap = true, silent = true, desc = "Changed quit all to leader+qa" }) -- quit all windows

-- bind ctrl movement
map("", "<c-j>", "<c-w>j", opts)
map("", "<c-k>", "<c-w>k", opts)
map("", "<c-l>", "<c-w>l", opts)
map("", "<c-h>", "<c-w>h", opts)

-- map sort function to a key
map("", "<Leader>s", ":sort<CR>", { noremap = true, silent = true, desc = "Sort lines" })

--  SPLITS

-- Resize vsplit
map("n", "<C-i>", ":vertical resize +5<cr>", { noremap = true, silent = true, desc = "Increase vertical split by 5" })
map("n", "<C-d>", ":vertical resize -5<cr>", { noremap = true, silent = true, desc = "Decrease vertical split by 5" })
map("n", "<C-r><C-d>", ":resize -5<cr>", { noremap = true, silent = true, desc = "Decrease horizontal split by 5" })
map("n", "<C-r><C-i>", ":resize +5<cr>", { noremap = true, silent = true, desc = "Increase horizaontal split by 5" })

-- Open splits
map("n", "<leader>sv", ":vsplit<cr>", { noremap = true, silent = true, desc = "Open vertical split" })
map("n", "<leader>sh", ":split<cr>", { noremap = true, silent = true, desc = "Open split" })

-- Create split below
map("n", ":sp", ":rightbelow sp<cr>", { noremap = true, silent = true, desc = "Open split right below" })

-- BUFFER
map("n", "<leader>bn", ":bnext<cr>", { desc = "Next Buffer", noremap = true, silent = true })
map("n", "<leader>bp", ":bprevious<cr>", { desc = "Previous Buffer", noremap = true, silent = true })
map("n", "<leader>bl", ":blast<cr>", { desc = "Last Buffer", noremap = true, silent = true })
map("n", "<leader>bx", ":bdelete<cr>", { desc = "Last Buffer", noremap = true, silent = true })
map("n", "<leader>bs", ":source %<cr>", { desc = "Source Buffer", noremap = true, silent = true })


-- Quickly go forward or backward to buffer

-- Navigate between quickfix items
map("n", "<leader>j", "<cmd>cnext<CR>zz", { desc = "QuickFixList Next" })
map("n", "<leader>k", "<cmd>cprev<CR>zz", { desc = "QuickFixList Previous" })


-- switch to last file in buffer
map("n", "<leader><leader>", ":b#<cr>", { noremap = true, silent = true, desc = "Switch to last file in buffer" })
--


-- Create/edit file in the current directory
map("n", ":ed", ":edit %:p:h/", { noremap = true, silent = true, desc = "Create edit file in the current directory" })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })
map('n', '<BS>', msg, { noremap = true, silent = false })


-- copy selection to system clipboard : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy selection to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Copy line selection to system clipboard" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to system clipboard" })

-- delete to blackhole
map("v", "<leader>d", '"_d', { noremap = true, silent = true, desc = "Delete selection to blackhole" })
map("v", "<leader>D", '"_D', { noremap = true, silent = true, desc = "Delete selection to blackhole" })

-- delete to blackhole
map("n", "<leader>d", '"_d', { noremap = true, silent = true, desc = "Delete selection to blackhole" })
map("n", "<leader>D", '"_D', { noremap = true, silent = true, desc = "Delete selection to blackhole" })

-- Disable arrow keys
-- Disable arrow keys in insert mode with a styled message
map('i', '<Up>', '<Nop>', { noremap = true, silent = false })
map('i', '<Down>', '<Nop>', { noremap = true, silent = false })
map('i', '<Left>', '<Nop>', { noremap = true, silent = false })
map('i', '<Right>', '<Nop>', { noremap = true, silent = false })

-- Disable arrow keys in normal mode with a styled message
map('n', '<Up>', '<Nop>', { noremap = true, silent = false })
map('n', '<Down>', '<Nop>', { noremap = true, silent = false })
map('n', '<Left>', '<Nop>', { noremap = true, silent = false })
map('n', '<Right>', '<Nop>', { noremap = true, silent = false })
