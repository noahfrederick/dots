" after/ftplugin/help.vim - Help filetype plug-in

set nonumber

if &columns > 180
  wincmd L
endif

nnoremap <buffer> q :quit<CR>

" vim: fdm=marker:sw=2:sts=2:et
