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

" Open new lines intelligently:
"   - List continuation (end list by hitting <Enter> twice)
"   - Block quote continuation
function! helper#markdown#OpenLine(trigger)
  let l:line = getline('.')

  if a:trigger !=? 'o'
    " When triggering from insert mode, use o instead to preserve indent
    let l:out = "\<Esc>o"
    let l:normal = 0
  else
    " Otherwise we can use the original command
    let l:out = a:trigger
    let l:normal = 1
  endif

  if l:line =~# '^\s*[-\*+>]\+ $'
    if l:normal == 0
      return "\<C-u>\<CR>"
    endif
  elseif l:line =~# '^\s*\d\+\. $'
    if l:normal == 0
      return "\<C-u>\<C-u>\<CR>"
    endif
  elseif l:line =~# '^\s*- '
    return l:out . "- "
  elseif l:line =~# '^\s*\(--\|++\) '
    return l:out . "-- "
  elseif l:line =~# '^\s*\* '
    return l:out . "* "
  elseif l:line =~# '^\s*+ '
    return l:out . "+ "
  elseif l:line =~# '^\s*> '
    return l:out . "> "
  elseif l:line =~# '^\s*\d\+\. '
    return "\<Esc>\"tyy\"tpf \"_DB\<C-a>A "
  endif

  return a:trigger
endfunction

" The gx mapping provided by the Netrw plug-in only works on WORDS. This
" provides support for opening links under the cursor:
function! helper#markdown#FollowLinkUnderCursor()
  let l:saved_reg = @t
  let l:saved_pos = getpos('.')

  normal! Bf("tyib
  let l:url = @t
  call netrw#NetrwBrowseX(url, 0)

  let @t = l:saved_reg
  call setpos('.', l:saved_pos)
endfunction
