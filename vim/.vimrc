syntax on
filetype off
filetype plugin indent on

"=============================================
" Visual configs
"=============================================

highlight Search cterm=underline
"buffer is hinden on iddle
set hidden

"always show status line
set laststatus=2

"highlight matching
set showmatch
set number " line numbers
"dont redraw on maracos
set lazyredraw

"enable mouse
set mouse=a

"allways show current postion
set ruler

"text dont wrap
set wrap

"show cmd
set showcmd

"highlight line with cursor
set cursorline

set showmode

set softtabstop=4

"set number of colors
set t_Co=256

"enable folding
set foldenable

set foldlevelstart=10
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level
set guifont=Source\ Code\ Pro:h12
set term=screen-256color
set autoindent
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

"=============================================
" SEARCH CONFIGS
"=============================================
"highlight search results
set hlsearch

"makes search with modern behavious
set incsearch

"=============================================
" MISC
"=============================================
"disable backup temp files
set nobackup
set nowb
set noswapfile

"set max history
set history=100

"set backspace to work as it should
set backspace=indent,eol,start
set colorcolumn=120

"text enconding
set encoding=utf-8

"text formating
set formatoptions=qrn1

set matchtime=3
set modelines=0

"set number of lines above and below the cursor
set scrolloff=3

"site of tab in spaces
set tabstop=4 shiftwidth=4 expandtab
set ttyfast
set undolevels=250
set visualbell

"paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

"=============================================
" WILDMENU COMPLETATION
"=============================================
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn " Version Controls"
set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
set wildignore+=*.spl "Compiled speolling world list"
set wildignore+=*.sw? "Vim swap files"
set wildignore+=*.DS_Store "OSX SHIT"
set wildignore+=*.luac "Lua byte code"
set wildignore+=migrations "Django migrations"
set wildignore+=*.orig "Merge resolution files"


"=============================================
" AUTO COMMANDS
"=============================================
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction
au VimEnter * nested :call LoadSession()
au VimLeave * :call MakeSession()

"" The PC is fast enough, do syntax highlight syncing from start
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END


"auto +x in scripts
au bufwritepost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile> | endif | endif

"source all vim files files
autocmd BufEnter * silent! lcd %:p:h "hanges the window-local current directory to be the same as the directory of the current file
"vim function

au BufWritePost .vimrc so $MYVIMRC

"============================================
" KEYBINDING
"============================================
"Rebing <leader>key
let mapleader = ","

"I can type :help on my own, thanks.
noremap <F1> <Esc>

"map esc to jk
imap <leader>e <Esc>

"change saving shortcut
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

"change quit shortcut::w
noremap <Leader>q :quit<CR> "Quit current window
noremap <leader>qa :qa!<CR> "quit all windows


"past mode
set pastetoggle=<F2>

"bind ctrl movement
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"map sort function to a key
noremap <Leader>s :sort<CR>

" ,ev Shortcut to edit .vimrc file on the fly on a vertical window.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
noremap <leader>rv :e $MYVIMRC<cr>

"<Ctrl-X> -- cut (goto visual mode and cut)
imap <C-X> <C-O>vgG
vmap <C-X> "*x<Esc>im

"<Ctrl-C> -- copy (goto visual mode and copy)
imap <C-C> <C-O>vgG
vmap <C-C> "*y<Esc>i

"<Ctrl-A> -- copy all
imap <C-A> <C-O>gg<C-O>gH<C-O>G<Esc>
vmap <C-A> <Esc>gggH<C-O>G<Esc>i

"<Ctrl-V> -- paste
nm \\paste\\ "=@*.'xy'<CR>gPFx"_2x:echo<CR>
imap <C-V> x<Esc>\\paste\\"_s
vmap <C-V> "-cx<Esc>\\paste\\"_x"""""""""""


"=============================================
" SPLITS
"=============================================

"Resize vsplit
nmap <C-i> :vertical resize +5<cr>
nmap <C-d> :vertical resize -5<cr>

"fullscreen
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

" Working with split screen nicely
" Resize Split When the window is resized"
au VimResized * :wincmd =
au VimResized * exe "normal! \<c-w>="

" Open splits
nmap <leader>vs :vsplit<cr>
nmap <leader>sp :split<cr>

" Create split below
nmap :sp :rightbelow sp<cr>

"=============================================
" BUFFER
"=============================================

" Quickly go forward or backward to buffer
nmap :bp :BufSurfBack<cr>
nmap :bn :BufSurfForward<cr>

"switch to last file in buffer
nmap <leader><leader> :b#<cr>

"=============================================
" VISUAL
"=============================================
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

" space open/closes folds
nmap <leader>za za

" Create/edit file in the current directory
nmap :ed :edit %:p:h/

"==============================================
" PLUGIN STUFF
"==============================================

call plug#begin('~/.vim/plugged')

Plug 'Shougo/unite.vim'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ervandew/supertab'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'
Plug 'chase/vim-ansible-yaml', { 'for': 'yaml' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --clangd-completer'}
Plug 'preservim/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'

" UI Plugins
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rainglow/vim'
Plug 'joshdick/onedark.vim'

call plug#end()
colorscheme onedark
"=============================================
" END PLUGIN
"=============================================

"=============================================
" PLUGIN SETTINGS
"=============================================

"=============================================
" UNITE
"=============================================

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ 'tmp/',
      \ 'vendor/',
      \ '.sass-cache',
      \ 'node_modules/',
      \ 'bower_components/',
      \ 'dist/',
      \ '.git5_specs/',
      \ '.pyc',
      \ ], '\|'))

"recent edited files
nnoremap <silent> <Leader>m :Unite -buffer-name=recent -winheight=10 file_mru<cr>
"
""recent buffers
nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>

nnoremap <Leader>f :Unite grep:.<cr>

" Start in insert mode
let g:unite_enable_start_insert = 1
"
let g:unite_data_directory = "~/.unite"

" " Open in bottom right
let g:unite_split_rule = "botright"
"
" " Shorten the default update date of 500ms
let g:unite_update_time = 200
"
let g:unite_source_file_mru_limit = 1000
let g:unite_cursor_line_highlight = 'TabLineSel'
"
let g:unite_source_file_mru_filename_format = ':~:.'
let g:unite_source_file_mru_time_format = ''

"=============================================
" ULLTISNIPS
"=============================================
let g:UltiSnipsExpandTrigger="<tab><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"=============================================
" TAGBAR
"=============================================
nmap <F8> :TagbarToggle<CR>

"=============================================
" ALE
"=============================================
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Run both javascript and vue linters for vue files.
let b:ale_linter_aliases = ['javascript', 'vue']
" " Select the eslint and vls linters.
let b:ale_linters = ['eslint', 'vls']
let g:ale_list_window_size = 10
nmap gd :ALEGoToDefinition<CR>
nmap gr :ALEFindReferences<CR>
nmap gR :ALERename<CR>
nmap K :ALEHover<CR>

"=============================================
" NERDTREE
"=============================================
autocmd vimenter * NERDTree
nmap <silent> <F9> :NERDTreeToggle<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeDirArrows = 1
map <leader>re :NERDTreeFind<cr>
"=============================================
" FUGITIVE
"=============================================
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gremove<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gm :Gmove
nnoremap <Leader>gp :Ggrep
nnoremap <Leader>gR :Gread<CR>
nnoremap <Leader>gg :Git
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gv :Gpull origin
nnoremap <Leader>gx :Gcommit -m ""
nnoremap <Leader>gc :Gpush origin

"=============================================
" GIT GUTTER
"=============================================
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterRevertHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk

"=============================================
" AIRLINE
"=============================================

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='bubblegum'

"=============================================
" FZF
"=============================================
nmap <C-P> :FZF<CR>

"=============================================
" END SETTINGS PLUGIN
"=============================================
