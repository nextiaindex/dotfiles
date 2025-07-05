let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-css-color'
Plug 'ayu-theme/ayu-vim'
call plug#end()

set number
set relativenumber
set shiftwidth=4
set tabstop=4
set list lcs=tab:\|\ 

set termguicolors
let ayucolor="mirage"
colorscheme ayu
highlight Normal guibg=#1f2430 

