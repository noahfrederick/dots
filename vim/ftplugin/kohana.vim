" ftplugin/kohana.vim - Settings for Kohana PHP buffers

if &filetype =~# '^php'
  let b:accio = ['php']
endif

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | unlet! b:accio
      \ '

" vim: fdm=marker:sw=2:sts=2:et
