" autoload/util/plug.vim - Plug helpers
" Maintainer: Noah Frederick

function! util#plug#LoadInsert()
  call plug#load('ultisnips')
  call plug#load('YouCompleteMe')
  call youcompleteme#Enable()

  doautocmd FileType
  autocmd! insert_mode_plugins

  echomsg "Loaded insert-mode plug-ins"
endfunction

function! util#plug#LoadIdle()
  call plug#load('syntastic')

  doautocmd FileType
  autocmd! idle_plugins

  echomsg "Loaded deferred plug-ins"
endfunction

" vim: fdm=marker:sw=2:sts=2:et
