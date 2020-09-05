" autoload/my/plug.vim - Plug helpers
" Maintainer: Noah Frederick

function! my#plug#load_insert_mode()
  call plug#load('lexima.vim')

  if &modifiable
    doautocmd FileType
  endif
endfunction

" vim: fdm=marker:sw=2:sts=2:et
