call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash'
Plug 'w0rp/ale'
Plug 'tpope/vim-rails'
call plug#end()

set nocompatible
filetype off
set backspace=indent,eol,start
let g:ruby_path = system('echo $HOME/.rbenv/shims')
let &runtimepath.=',~/.vim/bundle/vim-rails,~/.vim/bundle/ale'
syntax on
filetype plugin indent on
set number
set hidden
colorscheme blue
set clipboard=unnamed
set nobackup
set noswapfile
set nowrap bs=2 fo=cqrt ls=2 shm=at tw=0 wm=0 ww=<,>,h,l 
set tabstop=2 shiftwidth=2 expandtab
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}
