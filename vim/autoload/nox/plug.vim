" autoload/nox/plug.vim - Plug helpers
" Maintainer: Noah Frederick

function! nox#plug#LoadInsert()
  call plug#load('ultisnips')
  call plug#load('YouCompleteMe')
  call plug#load('lexima.vim')
  call youcompleteme#Enable()

  doautocmd FileType
  autocmd! insert_mode_plugins

  echomsg "Loaded insert-mode plug-ins"
endfunction

function! nox#plug#LoadIdle()
  call plug#load('syntastic')

  if &modifiable
    doautocmd FileType
  endif

  autocmd! idle_plugins

  echomsg "Loaded deferred plug-ins"
endfunction

" vim: fdm=marker:sw=2:sts=2:et
