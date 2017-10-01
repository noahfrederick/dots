" autoload/my/org/shopping.vim - Organizer and note-taking system
" Maintainer:   Noah Frederick

function! my#org#shopping#list(...) abort
  let new = get(a:000, 0, 0)
  let today = my#org#repo('shopping').note(strftime('%Y-%m-%d'))

  " If today's list already exists, just edit it
  if filereadable(today)
    execute 'edit' today
    return
  endif

  " Get file name of most recent list
  let fn = remove(my#org#repo('shopping').notes(), -1)

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

" vim: fdm=marker:sw=2:sts=2:et
