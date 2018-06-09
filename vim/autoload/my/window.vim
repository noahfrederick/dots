" autoload/my/window.vim - Window functions
" Maintainer: Noah Frederick

function! my#window#nav(key) abort
  let curwin = winnr()
  execute 'wincmd' a:key

  if curwin == winnr()
    if a:key =~# '[jk]'
      wincmd s
    else
      wincmd v
    endif

    execute 'wincmd' a:key
  endif
endfunction

" vim: fdm=marker:sw=2:sts=2:et
