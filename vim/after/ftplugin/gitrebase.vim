" after/ftplugin/gitrebase.vim - Extensions to Git rebase
" Maintainer: Noah Frederick

function! s:switch(to) abort
  let line = getline('.')

  if empty(line) || line[0] ==# '#'
    return ''
  endif

  return "^ciw" . a:to . "\<Esc>^"
endfunction

nnoremap <nowait><buffer><expr> p <SID>switch('pick')
nnoremap <nowait><buffer><expr> r <SID>switch('reword')
nnoremap <nowait><buffer><expr> e <SID>switch('edit')
nnoremap <nowait><buffer><expr> s <SID>switch('squash')
nnoremap <nowait><buffer><expr> f <SID>switch('fixup')
nnoremap <nowait><buffer><expr> x <SID>switch('exec')
nnoremap <nowait><buffer><expr> d <SID>switch('drop')

" vim: fdm=marker:sw=2:sts=2:et
