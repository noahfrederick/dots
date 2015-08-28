" ftplugin/prestashop.vim - Settings for PrestaShop buffers

if &filetype =~# '^php'
  let b:syntastic_checkers = ["php", "phpcs"]
  let b:syntastic_php_phpcs_post_args = "--standard=Prestashop --tab-width=0"
endif

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | unlet! b:syntastic_checkers b:syntastic_php_phpcs_post_args
      \ '

" vim: fdm=marker:sw=2:sts=2:et
