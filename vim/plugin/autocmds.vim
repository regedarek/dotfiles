if has('autocmd')
  augroup RegedarekAutocmds
    autocmd!
    if exists('+colorcolumn')
      autocmd BufEnter,FocusGained,VimEnter,WinEnter * if autocmds#should_colorcolumn() | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
      autocmd FocusLost,WinLeave * if autocmds#should_colorcolumn() | let &l:colorcolumn=join(range(1, 255), ',') | endif
    endif
    if has('statusline')
      autocmd BufEnter,FocusGained,VimEnter,WinEnter * call autocmds#focus_statusline()
      autocmd FocusLost,WinLeave * call autocmds#blur_statusline()
    endif
    if exists('*matchaddpos')
      autocmd BufEnter,FocusGained,VimEnter,WinEnter * call autocmds#focus_window()
      autocmd FocusLost,WinLeave * call autocmds#blur_window()
    endif
  augroup END

  augroup Idleboot
    autocmd!
    if has('vim_starting')
      autocmd CursorHold,CursorHoldI * call autocmds#idleboot()
    endif
  augroup END
endif


