" after/ftplugin/make.vim - Make
" Maintainer: Noah Frederick

if exists(':Switch')
  call plug#load('switch.vim')

  let b:switch_custom_definitions = [
        \   switch#NormalizedCase(['yes', 'no'])
        \ ]
endif

" vim: fdm=marker:sw=2:sts=2:et
