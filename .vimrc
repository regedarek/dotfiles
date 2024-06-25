packadd minpac

call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('tpope/vim-vinegar')
call minpac#add('morhetz/gruvbox')
call minpac#add('christoomey/vim-tmux-navigator')
call minpac#add('ludovicchabant/vim-gutentags')
call minpac#add('voldikss/vim-floaterm')
call minpac#add('benmills/vimux', {'type': 'opt'})
call minpac#add('arcticicestudio/nord-vim')
call minpac#add('thoughtbot/vim-rspec')
call minpac#add('pangloss/vim-javascript', {'type': 'opt'})
call minpac#add('maxmellon/vim-jsx-pretty', {'type': 'opt'})
call minpac#add('tpope/vim-eunuch')
call minpac#add('tpope/vim-endwise')
call minpac#add('wincent/scalpel')
call minpac#add('wincent/terminus')
call minpac#add('mbbill/undotree')
call minpac#add('wincent/ferret')
call minpac#add('wincent/loupe')
call minpac#add('Yggdroot/indentLine')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
call minpac#add('junegunn/fzf.vim')
call minpac#add('majutsushi/tagbar')
call minpac#add('weirongxu/plantuml-previewer.vim')
call minpac#add('aklt/plantuml-syntax')
call minpac#add('tyru/open-browser.vim')
call minpac#add('github/copilot.vim')

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

let mapleader="\<Space>"
let g:ruby_path = system('echo $HOME/.rbenv/shims')
let g:undotree_WindowLayout = 2

filetype indent plugin on
syntax on

set termguicolors
set background=light
colorscheme nord

let g:tagbar_type_ruby = {
            \ 'kinds' : [
                \ 'm:modules',
                \ 'c:classes',
                \ 'f:methods',
                \ 'F:singleton methods',
                \ 'C:constants',
                \ 'a:aliases'
            \ ],
            \ 'ctagsbin':  'ctags',
            \ }

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \                    <bang>0 ? fzf#vim#with_preview('up:60%')
  \                            : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                    <bang>0)
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
