" autoload/util/editing.vim - Global helpers for editing tasks
" Maintainer:   Noah Frederick

" Execute commands without moving cursor, changing search pattern
"
" - First parameter is a function name to call as a string
" - Second (optional) parameter is an array of arguments to pass to the
"   function
function! util#editing#Preserve(func, ...)
  let l:FuncRef = function(a:func)
  if a:0 > 0
    let l:args = a:1
  else
    let l:args = []
  endif

  let l:saved_search = @/
  let l:saved_view = winsaveview()

  let l:return_value = call(l:FuncRef, l:args)

  call winrestview(l:saved_view)
  let @/ = l:saved_search

  return l:return_value
endfunction

function! s:NormalizeWhitespace()
  " 1. Strip trailing whitespace
  %substitute/\s\+$//e
  " 2. Merge consecutive blank lines
  %substitute/\n\{3,}/\r\r/e
  " 3. Strip empty line from end of file
  %substitute/\n\+\%$//e
endfunction

function! util#editing#NormalizeWhitespace()
  return util#editing#Preserve('<SID>NormalizeWhitespace')
endfunction

function! s:ReindentBuffer()
  normal! gg=G
endfunction

function! util#editing#ReindentBuffer()
  return util#editing#Preserve('<SID>ReindentBuffer')
endfunction

function! s:YankBuffer()
  normal! ggyG
endfunction

function! util#editing#YankBuffer()
  return util#editing#Preserve('<SID>YankBuffer')
endfunction

function! util#editing#NormalModeDigraph(char2)
  let l:char1 = matchstr(getline('.'), '.', byteidx(getline('.'), col('.') - 1))
  echo 'digraph: ' . l:char1 . a:char2
  return "r\<C-k>" . l:char1 . a:char2
endfunction
