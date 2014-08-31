" autoload/util/path.vim - Global helpers for dealing with file paths
" Maintainer:   Noah Frederick

let g:compiled_file_locations = {
      \ 'less':   [['.', '.css'],    ['../css', '.css'],  ['.', 'bootstrap.css']],
      \ 'sass':   [['.', '.css'],    ['../css', '.css']],
      \ 'scss':   [['.', '.css'],    ['../css', '.css']],
      \ 'jade':   [['.', '.html'],   ['..', '.html']],
      \ 'haml':   [['.', '.html'],   ['..', '.html']],
      \ 'js':     [['.', '.min.js']],
      \ 'coffee': [['.', '.min.js'], ['../js', '.js']],
      \ 'md':     [['.', '.pdf']],
      \ }

function! util#path#CompiledVersion(path)
  let l:ext = fnamemodify(a:path, ':e')

  if has_key(g:compiled_file_locations, l:ext)
    return util#path#FindFileWithAlternateName(a:path, g:compiled_file_locations[l:ext])
  endif
endfunction

function! util#path#FindFileWithAlternateName(path, alternates)
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

function! util#path#CompleteHead(path_prefix, filename_pattern, A, L, P)
  let matches = split(globpath(a:path_prefix, '**/' . a:A . a:filename_pattern), "\n")
  return map(matches, 'fnamemodify(v:val, ":s?' . a:path_prefix . '/??:r")')
endfunction

" Follow symlink to actual file
function! util#path#FollowSymlink()
  " Get path of actual file
  let fname = resolve(expand("%:p"))
  " Rename buffer with new path
  execute "file " . fname
  " Read file again to trigger any plug-ins that are context-sensitive
  edit
endfunction

""
" Remove {prefix} and everything before it from {path}, returning the result
function! util#path#RemovePrefix(prefix, path)
  if type(a:prefix) ==# type([])
    let prefixes = a:prefix
  else
    let prefixes = [a:prefix]
  endif

  let path = '/' . a:path

  for prefix in prefixes
    let pos = stridx(path, prefix)
    if pos != -1
      return strpart(path, pos + strlen(prefix))
    endif
  endfor

  return a:path
endfunction

" vim:set et sw=2:
