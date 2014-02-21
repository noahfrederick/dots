" autoload/helper.vim - Global miscellaneous helper functions
" Maintainer:   Noah Frederick

" 'Quickfix do' analogous to :argdo, :bufdo, etc.
" Adapted from https://github.com/romainl/dotvim/blob/master/autoload/functions.vim
function helper#Cdo(command)
  try
    silent cfirst

    while 1
      execute a:command
      silent cnfile
    endwhile
  catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/
  endtry
endfunction

" Show highlight group of character under cursor
function! helper#SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line("."), col(".")), "synIDattr(v:val, 'name')")
endfunction

" vim:set et sw=2:
