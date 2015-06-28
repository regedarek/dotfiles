set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'sgur/ctrlp-extensions.vim'
Plugin 'jasoncodes/ctrlp-modified.vim'
Plugin 'iurifq/ctrlp-rails.vim'
Plugin 'DavidEGx/ctrlp-smarttabs'
Plugin 'qpkorr/vim-bufkill'
Plugin 'd11wtq/ctrlp_bdelete.vim'
Plugin 'rking/ag.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'duff/vim-bufonly'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'ervandew/supertab'
Plugin 'Shougo/neocomplete.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'AndrewRadev/switch.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-haml'
Plugin 'airblade/vim-rooter'
Plugin 'slim-template/vim-slim'
Plugin 'dkprice/vim-easygrep'
Plugin 'justinmk/vim-sneak'

call vundle#end()
filetype plugin indent on

colorscheme base16-railscasts
syntax enable

set clipboard=unnamed
set noswapfile
set autoread
set switchbuf=useopen
set winwidth=79
set t_ti= t_te=
set scrolloff=3
set expandtab shiftwidth=2
set softtabstop=2 tabstop=2
set autoindent
set showmatch
set noesckeys " ?
set nofoldenable
set number
set laststatus=2
set noshowmode
set t_Co=256
set background=dark
set incsearch
set hlsearch
set notimeout
set ttimeout " ?
set backspace=indent,eol,start " ?
set ignorecase smartcase
set wildignore+=*.o,*.png,*.gif,*.obj
set wildignore+=.git,*/public/*,*/tmp/*,*/log/*
set wildignore+=*.so,*.swp,*.zip
set complete=.,b,u,]
set wildmode=longest,list:longest
set completeopt=menu,preview

" General
let mapleader=','

" Keys maps
map <silent> <F1> :BufExplorer<CR>
map <silent> <F2> :Gstatus<CR>
map <silent> <F7> :s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>
map q: :q
map Q <Nop>
imap jj <Esc>
imap ww <C-O>:update<CR><Esc>
nmap ww      :update<CR>
vmap ww <C-C>:update<CR>
nmap zz v$h
nmap <silent> <Leader>rt :let @+='rt '.expand("%:p")<CR>
nmap <silent> <Leader>d :BufOnly<CR>
nmap <silent> ff        :BD<CR>
nmap <S-j> <<
nmap <S-k> >>
nmap <silent> <Leader>sn :! spotify next<CR> :redraw!<CR>
nmap <silent> <Leader>sb :! spotify prev<CR> :redraw!<CR>
nmap <silent> <Leader>sp :! spotify pause<CR> :redraw!<CR>
vmap < <gv
vmap > >gv
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l
nmap <CR> :nohlsearch<CR>
imap <c-c> <esc>
nmap <leader>w :StripWhitespace<CR>
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S

" Custom Autocommands
augroup vimrcEx
  autocmd!
  autocmd FileType text setlocal textwidth=78

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Unbind <enter> nohl behaviour on quickfix
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
  autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

" Ag
let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'

" CtrlP
let g:ctrlp_custom_ignore = {
      \ 'file': '\v\.(exe|dat|so|dll|log|gif|jpg|jpeg|png)$'
      \ }
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_map = '<c-p>'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'
let g:ctrlp_extensions = ['yankring', 'modified', 'branch', 'models', 'libs', 'views', 'specs', 'controllers', 'smarttabs']
let g:ctrlp_mruf_relative = 1
let g:ctrlp_mruf_exclude = '\v\.git/(MERGE_MSG|rebase-merge|COMMIT_EDITMSG|PULLREQ_EDITMSG|index)'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_last_entered = 1
let g:ctrlp_prompt_mappings = {
      \ 'PrtSelectMove("j")': ['<c-j>'],
      \ 'PrtSelectMove("k")': ['<c-k>'],
      \ 'CreateNewFile()': ['<c-n>'],
      \ 'ToggleType(1)': ['<c-h>', '<tab>'],
      \ 'ToggleType(-1)': ['<c-l>'],
      \ 'MarkToOpen()': ['<s-l>'],
      \ 'OpenMulti()': ['<s-D>'],
      \ }
let g:ctrlp_open_new_file = 0
let g:ctrlp_open_multi = 'vr'
let g:ctrlp_arg_map = 0
let g:ctrlp_jump_to_buffer = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_dotfiles = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
let g:ctrlp_cmd = 'call CallCtrlP()'

func! CallCtrlP()
    if exists('s:called_ctrlp')
        CtrlPLastMode
    else
        let s:called_ctrlp = 1
        CtrlPMenu
    endif
endfunc
call ctrlp_bdelete#init()

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename', 'ctrlp', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], ['filetype' ] ]
      \ },
      \ 'component': {
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'component_function': {
      \   'ctrlp': 'LightlineCtrlP'
      \ }
      \}

function! MyMode()
  let fname = expand('%:t')
  return fname == 'ControlP' ? 'CtrlP' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineCtrlP()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_item], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

" Neocomplete
let g:neocomplete#enable_at_startup = 1
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
call neocomplete#custom#source('syntax',
\ 'disabled_filetypes', {'ruby' : 1})

" Supertab
let g:SuperTabDefaultCompletionType = "<tab>"

" Netrw
let g:netrw_liststyle = 0
let g:netrw_list_hide = '^\..*\.swp$,^\.DS_Store$'
let g:netrw_special_syntax = 1

" EasyGrep
set grepprg=ag\ --hidden\ --vimgrep
set grepformat=%f:%l:%c:%m
