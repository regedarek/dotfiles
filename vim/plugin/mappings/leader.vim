nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>
nnoremap <Leader><Leader> <C-^>
nnoremap <Leader>o :tabnew %<CR>
nnoremap <Leader>d g*<CR>

nnoremap <silent> <Leader>zz :call mappings#leader#zap()<CR>
nnoremap <silent> <Leader>r :call mappings#leader#cycle_numbering()<CR>

silent! map <Leader>rt :call RunCurrentSpecFile()<CR>
silent! map <Leader>rs :call RunNearestSpec()<CR>
silent! map <Leader>rl :call RunLastSpec()<CR>
silent! map <Leader>ra :call RunAllSpecs()<CR>
silent! map <unique> <Leader>. :<Up><CR>
silent! map <unique> <Leader>a :A<CR>
silent! map <unique> <Leader>u :UndotreeToggle<CR>
silent! map <unique> <Leader>gf :GFiles?<CR>

nnoremap <LocalLeader>e :edit <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <LocalLeader>v :cd ~/.config/nvim/<CR>:edit ~/.config/nvim/<CR>

nnoremap <silent> <Tab><Tab> :FloatermToggle<CR>
