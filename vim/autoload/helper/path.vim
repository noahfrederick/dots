" autoload/helper/path.vim - Global helpers for dealing with file paths
" Maintainer:   Noah Frederick

let g:compiled_file_locations = {
      \ 'less':   [['.', '.css'],    ['../css', '.css'],  ['.', 'bootstrap.css']],
      \ 'sass':   [['.', '.css'],    ['../css', '.css']],
      \ 'scss':   [['.', '.css'],    ['../css', '.css']],
      \ 'jade':   [['.', '.html'],   ['..', '.html']],
      \ 'haml':   [['.', '.html'],   ['..', '.html']],
      \ 'js':     [['.', '.min.js']],
      \ 'coffee': [['.', '.min.js'], ['../js', '.js']],
      \ 'md':     [['.', '.pdf'],    ['.', '.html']],
      \ }

function! helper#path#CompiledVersion(path)
  let l:ext = fnamemodify(a:path, ':e')

  if has_key(g:compiled_file_locations, l:ext)
    return helper#path#FindFileWithAlternateName(a:path, g:compiled_file_locations[l:ext])
  endif
endfunction

function! helper#path#FindFileWithAlternateName(path, alternates)
  let l:head = fnamemodify(a:path, ':h')
  let l:base = fnamemodify(a:path, ':t:r')

  for [l:dir, l:suffix] in a:alternates
    let l:new_path = s:construct_path_with_new_suffix(l:head, l:dir, l:base, l:suffix)
    if filereadable(l:new_path)
      return l:new_path
    endif
  endfor

  return ''
endfunction

function! s:construct_path_with_new_suffix(head, dir, base, new_suffix)
  if a:new_suffix[0] ==# '.'
    let l:filename = a:base . a:new_suffix
  else
    let l:filename = a:new_suffix
  endif
  return resolve(a:head . '/' . a:dir . '/' . l:filename)
endfunction

function! helper#path#CompleteHead(path_prefix, filename_pattern, A, L, P)
  let matches = split(globpath(a:path_prefix, '**/' . a:A . a:filename_pattern), "\n")
  return map(matches, 'fnamemodify(v:val, ":s?' . a:path_prefix . '/??:r")')
endfunction

" vim:set et sw=2:
