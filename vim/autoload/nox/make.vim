" autoload/nox/make.vim - Global helpers for compilation
" Maintainer:   Noah Frederick

" Run :make (or :Make) only if compiled file already exists (useful for, e.g.,
" calling in a BufWritePost autocmd):
"
"   autocmd BufWritePost *.md call nox#make#Recompile(expand('<afile>'))
"
function! nox#make#Recompile(path)
  if a:path == ''
    let l:path = expand('%:p')
  else
    let l:path = a:path
  endif

  if nox#path#CompiledVersion(l:path) != ''
    if exists(':Make')
      Make
    else
      make
    endif
  endif
endfunction

" vim:set et sw=2:
