" autoload/util.vim - Global miscellaneous helper functions
" Maintainer:   Noah Frederick

" 'Quickfix do' analogous to :argdo, :bufdo, etc.
" Adapted from https://github.com/romainl/dotvim/blob/97e23dceda3afe6f9112172afab5741456893254/autoload/functions.vim
function! util#Cdo(filewise, cmd)
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

function! util#ShoppingList() abort
  let today = join([$NOTES, "shopping", strftime("%Y-%m-%d") . ".md"], "/")

  " If today's list already exists, just edit it
  if filereadable(today)
    execute join(["edit", today])
    return
  endif

  " Get file name of most recent list
  let glob = join([$NOTES, "shopping", "*.md"], "/")
  let fn = system(join(["ls", glob, "|", "tail -1"]))
  let fn = substitute(fn, "\n", "", "")

  " Copy to today list
  execute join(["silent", "edit", fn])
  execute join(["keepalt", "file", today])

  normal! zi
  " Uncheck all checkboxes
  silent keeppatterns %s/^\s*++ /-- /e
  set modified
  1
endfunction

" vim:set et sw=2:
