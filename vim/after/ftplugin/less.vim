" after/ftplugin/less.vim - Settings for Less

runtime after/ftplugin/css.vim

autocmd BufWritePost <buffer> Accio lessc

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | autocmd! BufWritePost <buffer>
      \ '

" vim: fdm=marker:sw=2:sts=2:et
