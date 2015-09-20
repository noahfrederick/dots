" autoload/nox/org.vim - Global organizational helpers
" Maintainer:   Noah Frederick

function! nox#org#shopping_list() abort
  let today = join([$NOTES, "shopping", strftime("%Y-%m-%d") . ".md"], "/")

  " If today's list already exists, just edit it
  if filereadable(today)
    execute "edit" today
    return
  endif

  " Get file name of most recent list
  let glob = join([$NOTES, "shopping", "*.md"], "/")
  let fn = system(join(["ls", glob, "|", "tail -1"]))
  let fn = substitute(fn, "\n", "", "")

  " Copy to today list
  execute "silent edit" fn
  execute "keepalt file" today

  normal! zi
  " Uncheck all checkboxes
  silent keeppatterns %s/^\s*\zs++ /-- /e
  silent keeppatterns %s/^\s*\zs- [x] /- [ ] /e
  set modified
  1
endfunction

" vim:set et sw=2:
