" autoload/my/display.vim - Screen/display utilities
" Maintainer: Noah Frederick

function! my#display#refresh() abort
  nohlsearch

  if has('diff')
    diffupdate
  endif

  if exists(':SignifyRefresh')
    SignifyRefresh
  endif

  redraw!
  syntax sync fromstart
  echo
endfunction

" vim: fdm=marker:sw=2:sts=2:et
