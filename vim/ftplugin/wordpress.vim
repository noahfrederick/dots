" ftplugin/wordpress.vim - Settings for WordPress buffers

let b:syntastic_php_phpcs_post_args = "--standard=WordPress"

let b:undo_ftplugin .= '
      \ | unlet! b:syntastic_php_phpcs_post_args
      \ '

" vim: fdm=marker:sw=2:sts=2:et
