" blink_search.vim - Blink search pattern after n and N
" Maintainer:   Noah Frederick

if exists("g:loaded_blink_search") || v:version < 700 || &cp
  finish
endif
let g:loaded_blink_search = 1

nnoremap <silent> n n:call <SID>BlinkCurrentMatch()<CR>
nnoremap <silent> N N:call <SID>BlinkCurrentMatch()<CR>

function! s:BlinkCurrentMatch()
  let target = '\c\%#'.@/
  let match = matchadd('IncSearch', target)
  redraw
  sleep 100m
  call matchdelete(match)
  redraw
endfunction

" vim: fdm=marker:sw=2:sts=2:et
