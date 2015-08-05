" ftplugin/laravel.vim - Settings for Laravel buffers

if &filetype =~# '^php'
  setlocal expandtab
  let b:syntastic_checkers = ["php", "phpcs", "phpmd"]
  let b:syntastic_php_phpcs_post_args = "--standard=PSR2"
endif

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | unlet! b:syntastic_checkers b:syntastic_php_phpcs_post_args
      \ '

" vim: fdm=marker:sw=2:sts=2:et
