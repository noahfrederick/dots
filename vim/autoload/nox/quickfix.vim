" autoload/nox/org.vim - Quick fix helpers
" Maintainer:   Noah Frederick

" Provide :cdo/:cfdo for older Vims
function! nox#quickfix#do(filewise, cmd)
  try
    silent cfirst

    while 1
      execute a:cmd

      if a:filewise > 0
        silent cnfile
      else
        silent cnext
      endif
    endwhile
  catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/
  endtry
endfunction

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
