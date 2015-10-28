call plug#begin('~/.vim/plugged')
Plug 'regedarek/neovim-clipboard'
Plug 'regedarek/vim-setup'
Plug 'Shougo/neomru.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'rking/ag.vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-endwise'
Plug 'christoomey/vim-tmux-navigator'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'atn34/vim-bbye'
Plug 'duff/vim-bufonly'
Plug 'vim-ruby/vim-ruby'
Plug 'kassio/neoterm'
Plug 'bogado/file-line'
Plug 'tpope/vim-rails'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'slim-template/vim-slim'
Plug 'troydm/zoomwintab.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tComment'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-rooter'
Plug 'ervandew/supertab'
Plug 'benekastah/neomake'
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
set showtabline=1
set laststatus=2
set number
set wrap
set backspace=2
set colorcolumn=+1
set textwidth=120
set hlsearch

" colorscheme
let g:seoul256_background = 252
colorscheme seoul256

" turn off vim-markdown folding
let g:vim_markdown_folding_disabled=1

" check syntax errors
autocmd! BufWritePost * Neomake

" leader mappings
let mapleader=','
nmap <silent> <leader>l :BuffergatorOpen<CR>
nmap <silent> <leader>bo :Bonly<CR>
nmap <silent> <leader>bn :bnext<CR>
nmap <silent> <M-h> :tabprev<cr>
nmap <silent> <M-l> :tabnext<cr>
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
nmap <silent> <leader>fd :e %:p:h/<CR>
nmap <silent> <leader>rcs :s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" correct typos
iabbrev initialise initialize
iabbrev initailise initialize
iabbrev initailize initialize
iabbrev intialize  initialize

" buffergator
let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = 'B'

" neoterm
nmap <silent> <leader>ta :call neoterm#test#run('all')<cr>
nmap <silent> <leader>tf :call neoterm#test#run('file')<cr>
nmap <silent> <leader>tn :call neoterm#test#run('current')<cr>
nmap <silent> <leader>tl :call neoterm#test#rerun()<cr>
nmap <silent> <leader>tk :call neoterm#kill()<cr>
nmap <silent> <leader>th :Tclose<cr>
let g:neoterm_keep_term_open = 0
let g:neoterm_run_tests_bg = 1
let g:neoterm_raise_when_tests_fail = 1
let g:neoterm_position = 'horizontal'

hi User1 ctermbg=gray ctermfg=red   guibg=green guifg=red
hi User2 ctermbg=red   ctermfg=blue  guibg=red   guifg=blue
hi User3 ctermbg=blue  ctermfg=green guibg=blue  guifg=green
set statusline=
set statusline+=%#NeotermTestRunning#%{neoterm#test#status('running')}%*
set statusline+=%#NeotermTestSuccess#%{neoterm#test#status('success')}%*
set statusline+=%#NeotermTestFailed#%{neoterm#test#status('failed')}%*
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%1*\ %<%F%*            "full path
set statusline +=%1*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%1*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
hi StatusLine ctermbg=3 ctermfg=4

tnoremap jj <C-\><C-n>

" neomake
let g:neomake_coffee_coffeelint_args = ['--reporter=csv', '-f', '.coffeelint.json']

command! -nargs=? -complete=file E tab new <args>
command! -nargs=? -complete=file EC tab new %:p:h/<args>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
