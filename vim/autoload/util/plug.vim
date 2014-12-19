" autoload/util/plug.vim - Plug helpers
" Maintainer: Noah Frederick

function! util#plug#LoadInsert()
  call plug#load('supertab')
  call plug#load('ultisnips')
  call plug#load('delimitMate')
  call plug#load('vim-endwise')
  call plug#load('YouCompleteMe')
  call youcompleteme#Enable()

  doautocmd FileType
  autocmd! insert_mode_plugins
endfunction

function! util#plug#LoadOnSave()
  call plug#load('syntastic')

  doautocmd FileType
  autocmd! on_save_plugins
endfunction

" vim: fdm=marker:sw=2:sts=2:et
