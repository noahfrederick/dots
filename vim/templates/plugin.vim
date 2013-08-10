" @FILENAME@ - @TITLE@
" Maintainer:   @AUTHOR@

if exists("g:loaded_@BASENAME@") || v:version < 700 || &cp
  finish
endif
let g:loaded_@BASENAME@ = 1

augroup @BASENAME@
  autocmd!
augroup END

" vim: fdm=marker:sw=2:sts=2:et
