" after/ftplugin/php.vim - Settings for PHP

" Use :make to check PHP syntax
setlocal makeprg=php\ -l\ % errorformat=%m\ in\ %f\ on\ line\ %l

" Folding options
setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal foldlevel=1
setlocal foldnestmax=2
" These are window-local, so they have to be unset on tear-down

" Settings for bundled PHP plug-in
let g:php_noShortTags = 1         " Always use <?php

let b:undo_ftplugin .= '
  \ | setlocal foldmethod< foldmarker< foldlevel< foldnestmax<
  \ '

" vim: fdm=marker:sw=2:sts=2:et
