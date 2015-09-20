" autoload/nox/plug.vim - Plug helpers
" Maintainer: Noah Frederick

function! nox#plug#load_insert_mode()
  call plug#load('ultisnips')
  call plug#load('YouCompleteMe')
  call plug#load('lexima.vim')
  call youcompleteme#Enable()

  doautocmd FileType
  autocmd! insert_mode_plugins
endfunction

function! nox#plug#load_idle()
  call plug#load('syntastic')

  if &modifiable
    doautocmd FileType
  endif

  autocmd! idle_plugins
endfunction

" vim: fdm=marker:sw=2:sts=2:et
