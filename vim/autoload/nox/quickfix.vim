" autoload/nox/org.vim - Quick fix helpers
" Maintainer:   Noah Frederick

function! nox#quickfix#toggle(type) abort
  if a:type !~# '[cl]'
    echoerr 'Invalid window type'
  endif

  try
    let window_count = winnr('$')
    execute a:type . 'close'

    if window_count == winnr('$')
      execute a:type . 'open'
    endif
  catch /^Vim\%((\a\+)\)\=:E776:/
    " No location list
  endtry
endfunction

" vim:set et sw=2:
