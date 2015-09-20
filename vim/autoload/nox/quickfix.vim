" autoload/nox/org.vim - Quick fix helpers
" Maintainer:   Noah Frederick

" 'Quickfix do' analogous to :argdo, :bufdo, etc.
" Adapted from https://github.com/romainl/dotvim/blob/97e23dceda3afe6f9112172afab5741456893254/autoload/functions.vim
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

" vim:set et sw=2:
