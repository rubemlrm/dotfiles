syntax on
filetype off
filetype plugin indent on
call plug#begin('~/.vim/plugged')
"source $VIMRUNTIME/mswin.vim
""behave mswin
set t_Co=256
set term=screen-256color
colorscheme seti
" automatically reload vimrc when it's saved
" "if has('win32') || has('win64')
au BufWritePost _vimrc so $MYVIMRC
"else
au BufWritePost .vimrc so $MYVIMRC
"endif
"
"
""settings
source ~/.vim/config/settings.vim

"keybinds
source ~/.vim/config/keybindings.vim
"" Plugin-specific configuration
source ~/.vim/config/plugin.vim
" Small custom functions.
source ~/.vim/config/functions.vim
" " Auto command
source ~/.vim/config/autocomands.vim

