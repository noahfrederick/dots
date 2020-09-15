" autoload/my/plug.vim - Plug helpers
" Maintainer: Noah Frederick

function! my#plug#load_insert_mode()
  call plug#load('lexima.vim')

  if &modifiable
    doautocmd FileType
  endif
endfunction

function! my#plug#install_phpactor(info)
  " Documentation advises against --global to avoid conflicts in dependencies.
  !composer install --no-dev -o

  if a:info.status ==# 'installed' || a:info.force
    call mkdir('~/.local/bin', 'p')
    execute '!ln -s' g:plug_home..'/phpactor/bin/phpactor' '~/.local/bin/phpactor'
  endif
endfunction

" vim: fdm=marker:sw=2:sts=2:et
