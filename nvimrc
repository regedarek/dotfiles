call plug#begin('~/.vim/plugged')
Plug 'regedarek/neovim-clipboard'
Plug 'regedarek/my-vim-mappings'
Plug 'regedarek/my-vim-autocommands'
Plug 'chriskempson/base16-vim'
Plug 'Shougo/neomru.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'rking/ag.vim'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-endwise'
Plug 'christoomey/vim-tmux-navigator'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'atn34/vim-bbye'
Plug 'duff/vim-bufonly'
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
Plug 'tpope/vim-dispatch'
Plug 'kassio/neoterm'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-rooter'
Plug 'ervandew/supertab'
Plug 'benekastah/neomake'
Plug 'janko-m/vim-test'
Plug 'regedarek/vim-test-configuration'
Plug 'szw/vim-ctrlspace'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rbenv'
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
set backspace=2
set colorcolumn=+1
set textwidth=120
set hlsearch

" colorscheme
let base16colorspace=256
colorscheme base16-railscasts
set background=dark
hi TabLine      ctermfg=Grey   ctermbg=Black     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Black     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=Black     cterm=NONE

" turn off vim-markdown folding
let g:vim_markdown_folding_disabled=1

" check syntax errors
autocmd! BufWritePost * Neomake

" leader mappings
let mapleader=','
nmap <silent> <leader>l :Buffers<CR>
nmap <silent> <leader>bl :Buffers<CR>
nmap <silent> <leader>bo :Bonly<CR>
nmap <silent> <leader>bn :bnext<CR>
nmap <silent> <leader>bp :bprev<CR>
nmap <silent> <leader>bd :Bdelete<CR>
nmap <silent> <leader>q :Bdelete<CR>
nmap <silent> <leader>d :Bdelete<CR>
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>n :NERDTreeToggle<CR>
nmap <silent> <leader>a :Ag<CR>
nmap <silent> <leader>ff :FZF!<CR>
nmap <silent> <leader>fl :Lines<CR>
nmap <silent> <leader>w :FixWhitespace<CR>
nmap <silent> <leader>h :History<CR>
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
nmap <silent> <leader>th :call neoterm#close_all()<cr>
nmap <silent> <leader>tc :call neoterm#clear()<cr>
nmap <silent> <leader>tk :call neoterm#kill()<cr>
nmap <silent> <leader>sn :! spotify next<CR> :redraw!<CR>
nmap <silent> <leader>sb :! spotify prev<CR> :redraw!<CR>
nmap <silent> <leader>sp :! spotify pause<CR> :redraw!<CR>
nmap <silent> <leader>rs :s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" tmux fix
nmap <bs> :<c-u>TmuxNavigateLeft<cr>

" terminal
let g:neoterm_size = 15
command! Troutes :T rake routes
command! -nargs=+ Troute :T rake routes | grep <args>
command! Tmigrate :T rake db:migrate
command! -nargs=+ Tg :T git <args>

" yankstack
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

let g:ag_working_path_mode="r"

" ctrlspace
set hidden
set showtabline=0
hi link CtrlSpaceNormal   PMenu
hi link CtrlSpaceSelected PMenuSel
hi link CtrlSpaceSearch   Search
hi link CtrlSpaceStatus   StatusLine

" neomru
nnoremap <silent> <Leader>m :call fzf#run({
\   'source': 'sed "1d" $HOME/.cache/neomru/file',
\   'sink': 'e '
\ })<CR>

" disable tags completion
set cpt-=t
