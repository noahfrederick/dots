" autoload/util/fzf.vim - Sources and sinks for fzf
" Maintainer:   Noah Frederick

function! util#fzf#Buffers()
  redir => output
  silent buffers
  redir END
  let buf_list = split(output, '\n')
  let alternate = matchstr(buf_list, '^\s*\d\+\s*#')
  " Remove current and alternate buffers from list
  call filter(buf_list, "v:val !~# '^\\s*\\d\\+\\s*[%#]'")

  if alternate != ''
    call add(buf_list, alternate)
  endif

  " Strip trailing line numbers
  call map(buf_list, "substitute(v:val, '\\s\\+line \\d\\+$', '', '')")
  return buf_list
endfunction

function! util#fzf#BufferOpen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

function! nox#fzf#BufferLines()
  let lines = map(getline(0, '$'), '(v:key + 1) . ":\t" . v:val')

  if exists('b:interesting_lines_filter')
    call filter(lines, 'strpart(v:val, stridx(v:val, "\t") + 1) =~# b:interesting_lines_filter')
  endif

  return lines
endfunction

function! nox#fzf#JumpToLine(l)
  let keys = split(a:l, ':\t')
  execute keys[0]
  normal! zz
endfunction

" vim:set et sw=2:
