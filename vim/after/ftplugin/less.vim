" after/ftplugin/less.vim - Settings for Less

let b:less_paths = []
let b:less_paths_arg = ''

if isdirectory('node_modules/bootstrap/less')
  call add(b:less_paths, 'node_modules/bootstrap/less')
endif

if isdirectory('bower_components/bootstrap/less')
  call add(b:less_paths, 'bower_components/bootstrap/less')
endif

if !empty(b:less_paths)
  let b:less_paths_arg = ' --include-path=' . join(b:less_paths, ';')
endif

let b:accio = 'lessc --lint' . b:less_paths_arg

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | unlet! b:accio
      \ '

" vim: fdm=marker:sw=2:sts=2:et
