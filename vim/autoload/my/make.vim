" autoload/my/make.vim - Global helpers for compilation
" Maintainer:   Noah Frederick

" Run :make (or :Make) only if compiled file already exists (useful for, e.g.,
" calling in a BufWritePost autocmd):
"
"   autocmd BufWritePost *.md call my#make#recompile(expand('<afile>'))
"
function! my#make#recompile(path)
  if a:path == ''
    let l:path = expand('%:p')
  else
    let l:path = a:path
  endif

  if !empty(my#path#find_compiled_version(l:path))
    if exists(':Make')
      Make
    else
      make
    endif
  endif
endfunction

" vim:set et sw=2:
