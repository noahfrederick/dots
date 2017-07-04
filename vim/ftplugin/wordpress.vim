" ftplugin/wordpress.vim - Settings for WordPress buffers

if &filetype =~# '^php'
  let b:compiler_phpcs_standard = "WordPress"
  let b:compiler_phpcs_tab_width = "0"
  " Because this is a global, multiple projects within the same session will
  " not play nicely.
  let g:neomake_php_phpcs_args_standard = "WordPress"
endif

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | unlet! b:compiler_phpcs_standard b:compiler_phpcs_tab_width g:neomake_php_phpcs_args_standard
      \ '

" vim: fdm=marker:sw=2:sts=2:et
