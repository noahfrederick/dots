" autoload/log.vim - Log messages to a list
" Maintainer: Noah Frederick

let s:log = []

function! my#log#add(message, ...) abort
  redir => entry
  echo strftime('%Y-%m-%d %H:%M:%S') a:message
  for item in a:000
    PP item
  endfor
  redir END

  return add(s:log, entry)
endfunction

function! my#log#dump() abort
  -tabedit [log]
  nohlsearch
  setlocal buftype=nofile bufhidden=wipe

  call append(0, s:log)

  nnoremap <buffer> q :bdelete<CR>
endfunction

" vim: fdm=marker:sw=2:sts=2:et
