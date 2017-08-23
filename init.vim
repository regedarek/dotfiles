if &compatible
  set nocompatible
endif

set runtimepath+=/Users/dariuszfinster/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/Users/dariuszfinster/.local/share/dein')
  call dein#begin('/Users/dariuszfinster/.local/share/dein')

  call dein#add('/Users/dariuszfinster/.local/share/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('chriskempson/base16-vim')
  call dein#add('tpope/vim-vinegar')
  call dein#add('junegunn/fzf', { 'build': './install' })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('mbbill/undotree')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('tpope/vim-endwise')
  call dein#add('floobits/floobits-neovim')
  call dein#add('duggiefresh/vim-easydir')
  call dein#add('tpope/vim-surround')
  call dein#add('wincent/ferret')
  call dein#add('tpope/vim-projectionist')
  call dein#add('tpope/vim-fugitive')
  "call dein#add('airblade/vim-gitgutter')
  "call dein#add('w0rp/ale')
  call dein#add('pangloss/vim-javascript')
  "call dein#add('mxw/vim-jsx')
  call dein#add('tpope/vim-rails')
  call dein#add('yaymukund/vim-rabl')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

colorscheme base16-railscasts

set backspace=indent,eol,start
set number
set hidden
set clipboard=unnamed
set nobackup
set mouse=a
set noswapfile
set nowrap bs=2 fo=cqrt ls=2 shm=at tw=0 wm=0 ww=<,>,h,l 
set tabstop=2 shiftwidth=2 expandtab
set updatetime=250
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}

nnoremap Q <nop>
nnoremap K <nop>
nnoremap q: <nop>
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>p :echo expand('%')<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

nnoremap <C-p> :FZF<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
