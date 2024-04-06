local ss = vim.opt
local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")

ss.filetype = on

--=============================================
-- Visual configs
--=============================================

-- buffer is hinden on iddle
ss.hidden = true

-- always show status line
ss.laststatus = 2

-- highlight matching
ss.showmatch = true
ss.number = true
ss.relativenumber = true
-- enable mouse

-- allways show current postion
ss.ruler = true

-- text dont wrap
ss.wrap = true

-- show cmd
ss.showcmd = true

-- highlight line with cursor
ss.cursorline = true

ss.showmode = true

ss.softtabstop = 4


-- enable folding
ss.foldenable = true

ss.foldlevelstart=10
ss.foldnestmax=10      --  10 nested fold max
ss.foldmethod="indent"   --  fold based on indent level
ss.guifont="Hack Nerd Font:h13"
ss.autoindent=true
ss.showtabline=2 --  Always display the tabline, even if there is only one tab
ss.undofile = true --  set undotree to save to file
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- =============================================
--  SEARCH CONFIGS
-- =============================================
-- highlight search results
ss.hlsearch = true

-- makes search with modern behavious
ss.incsearch = true

-- =============================================
--  MISC
-- =============================================
-- disable backup temp files
ss.backup = false
ss.swapfile = false

-- text enconding
ss.encoding="utf-8"
-- text formattiny
ss.matchtime=3
ss.modelines=0
-- set number of lines above and below the cursor
ss.scrolloff=3
-- site of tab in spaces
ss.tabstop=4
ss.shiftwidth=4
ss.expandtab=true


-- paste
-- nnoremap <F2> :set invpaste paste?<CR>
ss.pastetoggle="<F2>"
ss.termguicolors = true
