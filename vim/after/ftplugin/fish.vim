" after/ftplugin/fish.vim - Settings for Fish

" Set options for fish scripts
silent! compiler fish
setlocal textwidth=78
setlocal foldmethod=expr
setlocal nofoldenable

let b:accio = 'fish'

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | setlocal foldmethod< textwidth<
      \ | unlet! b:accio
      \ '

" vim: fdm=marker:sw=2:sts=2:et
