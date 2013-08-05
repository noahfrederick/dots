" Promote/demote headings
function! helper#markdown#PromoteHeading()
  let l:line = getline('.')

  if l:line =~# '^##\+ '
    let l:saved_pos = getpos('.')
    normal! ^"_x
    let l:saved_pos[2] = l:saved_pos[2] - 1
    call setpos('.', l:saved_pos)
  endif
endfunction

function! helper#markdown#DemoteHeading()
  let l:line = getline('.')

  if l:line =~# '^######'
    return
  endif

  let l:saved_reg = @t
  let l:saved_pos = getpos('.')

  if l:line =~# '^#'
    let l:saved_pos[2] = l:saved_pos[2] + 1
    let @t = '#'
  else
    let l:saved_pos[2] = l:saved_pos[2] + 2
    let @t = '# '
  endif

  normal! ^"tP

  let @t = l:saved_reg
  call setpos('.', l:saved_pos)
endfunction

" Smart <Enter> in insert mode:
"   - List continuation (end list by hitting <Enter> twice)
"   - Block quote continuation
function! helper#markdown#ExpandCR()
  let l:line = getline('.')

  if l:line =~# '^\s*[-\*+>] $'
    return "\<C-u>\<CR>"
  elseif l:line =~# '^\s*\d\+\. $'
    return "\<C-u>\<C-u>\<CR>"
  elseif l:line =~# '^\s*- '
    return "\<Esc>o- "
  elseif l:line =~# '^\s*\* '
    return "\<Esc>o* "
  elseif l:line =~# '^\s*+ '
    return "\<Esc>o+ "
  elseif l:line =~# '^\s*> '
    return "\<Esc>o> "
  elseif l:line =~# '^\s*\d\+\. '
    return "\<Esc>\"tyy\"tpf \"_DB\<C-a>A "
  endif

  return "\<CR>"
endfunction
