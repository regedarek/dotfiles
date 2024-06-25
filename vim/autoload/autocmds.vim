let g:ColorColumnBlacklist = ['diff', 'undotree', 'qf', 'tagbar']

function! autocmds#should_colorcolumn() abort
  return index(g:ColorColumnBlacklist, &filetype) == -1
endfunction

function! autocmds#idleboot() abort
  " Make sure we automatically call autocmds#idleboot() only once.
  augroup Idleboot
    autocmd!
  augroup END

  " Make sure we run deferred tasks exactly once.
  doautocmd User RegedarekDefer
  autocmd! User RegedarekDefer
endfunction

function! autocmds#blur_window() abort
  if autocmds#should_colorcolumn()
    if !exists('w:matches')
      " Instead of unconditionally resetting, append to existing array.
      " This allows us to gracefully handle duplicate autocmds.
      let w:matches=[]
    endif
    let l:height=&lines
    let l:slop=l:height / 2
    let l:start=max([1, line('w0') - l:slop])
    let l:end=min([line('$'), line('w$') + l:slop])
    while l:start <= l:end
      let l:next=l:start + 8
      let l:id=matchaddpos(
            \   'StatusLineStyle',
            \   range(l:start, min([l:end, l:next])),
            \   0
            \ )
      call add(w:matches, l:id)
      let l:start=l:next
    endwhile
  endif
endfunction

function! autocmds#focus_window() abort
  if autocmds#should_colorcolumn()
    if exists('w:matches')
      for l:match in w:matches
        try
          call matchdelete(l:match)
        catch /.*/
          " In testing, not getting any error here, but being ultra-cautious.
        endtry
      endfor
      let w:matches=[]
    endif
  endif
endfunction

function! autocmds#focus_statusline() abort
  let l:focused='\ ' " space
  let l:focused.='\ ' " space
  let l:focused.='\ ' " space
  let l:focused.='\ ' " space
  let l:focused.='%<' " truncation point
  let l:focused.='%f' " filename
  let l:focused.='%=' " split left/right halves (makes background cover whole)
  call s:update_statusline(l:focused, 'focus')
endfunction

function! autocmds#blur_statusline() abort
  let l:blurred='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='%<' " truncation point
  let l:blurred.='%t' " filename
  let l:blurred.='%=' " split left/right halves (makes background cover whole)
  call s:update_statusline(l:blurred, 'blur')
endfunction

function! s:update_statusline(default, action) abort
  let l:statusline = 1
  if type(l:statusline) == type('')
    execute 'setlocal statusline=' . l:statusline
  elseif l:statusline == 0
    return
  else
    execute 'setlocal statusline=' . a:default
  endif
endfunction
