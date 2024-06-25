let s:deoplete_init_done=0
function! autocomplete#deoplete_init() abort
  if s:deoplete_init_done || !has('nvim')
    return
  endif
  packadd! deoplete.nvim
  let s:deoplete_init_done=1
  call deoplete#enable()
endfunction
