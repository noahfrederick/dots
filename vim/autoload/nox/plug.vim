" autoload/nox/plug.vim - Plug helpers
" Maintainer: Noah Frederick

function! nox#plug#load_insert_mode()
  call plug#load('ultisnips', 'YouCompleteMe', 'lexima.vim')
  call youcompleteme#Enable()

  if &modifiable
    doautocmd FileType
  endif
endfunction

function! nox#plug#load_idle()
  call plug#load('syntastic')

  if &modifiable
    doautocmd FileType
  endif
endfunction

" vim: fdm=marker:sw=2:sts=2:et
