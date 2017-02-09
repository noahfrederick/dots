" autoload/nox/org.vim - Global organizational helpers
" Maintainer:   Noah Frederick

function! nox#org#shopping_list(...) abort
  let new = get(a:000, 0, 0)
  let today = join([$NOTES, 'shopping', strftime('%Y-%m-%d') . '.md'], '/')

  " If today's list already exists, just edit it
  if filereadable(today)
    execute 'edit' today
    return
  endif

  " Get file name of most recent list
  let fn = remove(glob('$NOTES/shopping/*.md', 1 , 1), -1)

  if !new
    " Edit the most recent list
    execute 'edit' fn
    return
  endif

  " Copy to today list
  execute 'silent edit' fn
  execute 'keepalt file' today

  normal! zi
  " Uncheck all checkboxes
  silent keeppatterns %s/^\s*\zs++ /-- /e
  silent keeppatterns %s/^\s*\zs- \[x] /- [ ] /e
  set modified
  1
endfunction

" vim:set et sw=2:
