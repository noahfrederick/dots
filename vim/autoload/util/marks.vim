" autoload/util/marks.vim - Mark helpers
" Maintainer: Noah Frederick

function! util#marks#Choose(bang) abort
  if a:bang ==# ''
    marks abcdefghijklmnopqrstuvwxyz.
  else
    marks
  endif

  echo 'Jump to mark (<Space> cancels): '
  let mark = nr2char(getchar())

  " Dismiss "Press ENTER or type command to continue" prompt
  redraw

  if mark !=# ' '
    execute 'normal! `' . mark
  endif
endfunction

" vim: fdm=marker:sw=2:sts=2:et
