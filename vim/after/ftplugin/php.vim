" after/ftplugin/php.vim - Settings for PHP

set suffixesadd+=.php

" Use :make to check PHP syntax
setlocal makeprg=php\ -l\ % errorformat=%m\ in\ %f\ on\ line\ %l

" Settings for bundled PHP plug-in
let g:php_noShortTags = 1         " Always use <?php

" Folding options
setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal foldlevel=1
setlocal foldnestmax=2
" These are window-local, so they have to be unset on tear-down

let b:undo_ftplugin .= '
  \ | setlocal foldmethod< foldmarker< foldlevel< foldnestmax<
  \ '

" vim: fdm=marker:sw=2:sts=2:et
