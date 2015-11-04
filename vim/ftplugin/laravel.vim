" ftplugin/laravel.vim - Settings for Laravel buffers

if &filetype =~# '^php'
  setlocal expandtab
  let b:compiler_phpcs_standard = "PSR2"
endif

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | unlet! b:compiler_phpcs_standard
      \ '

" vim: fdm=marker:sw=2:sts=2:et
