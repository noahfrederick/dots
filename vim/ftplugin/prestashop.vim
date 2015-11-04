" ftplugin/prestashop.vim - Settings for PrestaShop buffers

if &filetype =~# '^php'
  let b:compiler_phpcs_standard = "Prestashop"
  let b:compiler_phpcs_tab_width = "0"
endif

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | unlet! b:compiler_phpcs_standard b:compiler_phpcs_tab_width
      \ '

" vim: fdm=marker:sw=2:sts=2:et
