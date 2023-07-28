vim.opt.filetype = on

--=============================================
-- Visual configs
--=============================================

-- buffer is hinden on iddle
vim.opt.hidden = true

-- always show status line
vim.opt.laststatus = 2

-- highlight matching
vim.opt.showmatch = true
vim.opt.number = true
-- enable mouse
vim.opt.mouse = a

-- allways show current postion
vim.opt.ruler = true

-- text dont wrap
vim.opt.wrap = true

-- show cmd
vim.opt.showcmd = true

-- highlight line with cursor
vim.opt.cursorline = true

vim.opt.showmode = true

vim.opt.softtabstop = 4


-- enable folding
vim.opt.foldenable = true

vim.opt.foldlevelstart=10
vim.opt.foldnestmax=10      --  10 nested fold max
vim.opt.foldmethod="indent"   --  fold based on indent level
vim.opt.guifont="Hack Nerd Font:h13"
vim.opt.autoindent=true
vim.opt.showtabline=2 --  Always display the tabline, even if there is only one tab
vim.opt.undofile = true --  set undotree to save to file
-- =============================================
--  SEARCH CONFIGS
-- =============================================
-- highlight search results
vim.opt.hlsearch = true

-- makes search with modern behavious
vim.opt.incsearch = true

-- =============================================
--  MISC
-- =============================================
-- disable backup temp files
vim.opt.backup = false
vim.opt.swapfile = false

-- set max history
vim.opt.history=100

-- set backspace to work as it should
vim.opt.backspace={'indent','eol','start'}
vim.opt.colorcolumn="120"

-- text enconding
vim.opt.encoding="utf-8"

-- text formating
vim.opt.formatoptions=qrn1

vim.opt.matchtime=3
vim.opt.modelines=0

-- set number of lines above and below the cursor
vim.opt.scrolloff=3

-- site of tab in spaces
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.ttyfast=true
vim.opt.undolevels=250
vim.opt.visualbell=true

-- paste
-- nnoremap <F2> :set invpaste paste?<CR>
vim.opt.pastetoggle="<F2>"
vim.opt.termguicolors = true
