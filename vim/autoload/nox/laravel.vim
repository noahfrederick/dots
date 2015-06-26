" autoload/nox/laravel.vim - Laravel helpers
" Maintainer: Noah Frederick

function! nox#laravel#BufferSetup()
  if &filetype ==# 'php'
    setlocal expandtab
    let b:syntastic_checkers = ["php", "phpcs", "phpmd"]
    let b:syntastic_php_phpcs_post_args = "--standard=PSR2"
  endif
endfunction

" vim: fdm=marker:sw=2:sts=2:et
