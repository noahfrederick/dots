" autoload/nox/plug.vim - Plug helpers
" Maintainer: Noah Frederick

function! nox#plug#load_insert_mode()
  call plug#load('ultisnips', 'lexima.vim')

  if &modifiable
    doautocmd FileType
  endif
endfunction

" vim: fdm=marker:sw=2:sts=2:et
