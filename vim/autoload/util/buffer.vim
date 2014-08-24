" autoload/util/buffer.vim - Global helpers for managing buffers
" Maintainer:   Noah Frederick

function! util#buffer#Bdelete(bang) abort
  let l:current_buffer = bufnr("%")
  let l:alternate_buffer = bufnr("#")

  if buflisted(l:alternate_buffer)
    execute "buffer" . a:bang . " #"
  else
    execute "bnext" . a:bang
  endif

  if bufnr("%") == l:current_buffer
    new
  endif

  if buflisted(l:current_buffer)
    execute "bdelete" . a:bang . " " . l:current_buffer
  endif
endfunction

" Adapted from http://www.vim.org/scripts/script.php?script_id=1071
function! util#buffer#Bufonly(buffer, bang)
  if a:buffer == ''
    " No buffer provided, use the current buffer.
    let buffer = bufnr('%')
  elseif (a:buffer + 0) > 0
    " A buffer number was provided.
    let buffer = bufnr(a:buffer + 0)
  else
    " A buffer name was provided.
    let buffer = bufnr(a:buffer)
  endif

  if buffer == -1
    echohl ErrorMsg
    echomsg "No matching buffer for" a:buffer
    echohl None
    return
  endif

  let last_buffer = bufnr('$')

  let delete_count = 0
  let n = 1
  while n <= last_buffer
    if n != buffer && buflisted(n)
      if a:bang == '' && getbufvar(n, '&modified')
        echohl ErrorMsg
        echomsg 'No write since last change for buffer'
              \ n '(add ! to override)'
        echohl None
      else
        silent exe 'bdel' . a:bang . ' ' . n
        if ! buflisted(n)
          let delete_count = delete_count + 1
        endif
      endif
    endif
    let n = n + 1
  endwhile

  if delete_count == 1
    echomsg delete_count "buffer deleted"
  elseif delete_count > 1
    echomsg delete_count "buffers deleted"
  endif
endfunction

" vim:set et sw=2:
