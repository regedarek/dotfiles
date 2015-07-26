call plug#begin('~/.vim/plugged')
Plug 'regedarek/neovim-clipboard'
Plug 'regedarek/my-vim-mappings'
Plug 'regedarek/my-vim-autocommands'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'regedarek/fzf-configuration'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'qpkorr/vim-bufkill'
Plug 'duff/vim-bufonly'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-rbenv'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'slim-template/vim-slim'
Plug 'troydm/zoomwintab.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tComment'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-rooter'
Plug 'ervandew/supertab'
Plug 'benekastah/neomake'
Plug 'janko-m/vim-test'
Plug 'regedarek/vim-test-configuration'
call plug#end()

filetype plugin indent on
syntax on
cabbr te tabedit
set clipboard+=unnamedplus
set noswapfile
set expandtab
set notimeout
set tabstop=2
set shiftwidth=2
set showtabline=2
set number
set wrap
set backspace=0
set colorcolumn=+1
set textwidth=100
set hlsearch

" colorscheme
let base16colorspace=256
set background=dark
colorscheme base16-default

" turn off vim-markdown folding
let g:vim_markdown_folding_disabled=1

" check syntax errors
autocmd! BufWritePost * Neomake

" leader mappings
let mapleader=','
nmap <silent> <leader>bo :Bonly<CR>
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>n :NERDTreeToggle<CR>
nmap <silent> <leader>m :FZFMru<CR>
nmap <silent> <leader>f :Ag<CR>
nmap <silent> <leader>ff :FZF!<CR>
nmap <silent> <leader>fl :FZFLines<CR>
nmap <silent> <leader>l :Locate /<CR>
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
nmap <silent> <Leader>sn :! spotify next<CR> :redraw!<CR>
nmap <silent> <Leader>sb :! spotify prev<CR> :redraw!<CR>
nmap <silent> <Leader>sp :! spotify pause<CR> :redraw!<CR>
nmap <silent> <Leader>rs :s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>
