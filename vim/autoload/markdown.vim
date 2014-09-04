" Promote/demote headings
function! markdown#PromoteHeading()
  let l:line = getline('.')

  if l:line =~# '^##\+ '
    let l:saved_pos = getpos('.')
    normal! ^"_x
    let l:saved_pos[2] = l:saved_pos[2] - 1
    call setpos('.', l:saved_pos)
  endif
endfunction

function! markdown#DemoteHeading()
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
function! markdown#OpenLine(trigger)
  let l:line = getline('.')

  if a:trigger !=? 'o'
    let l:normal = 0
  else
    let l:normal = 1
  endif

  let l:out = a:trigger

  if l:line =~# '^\s*[-\*+>]\+ $'
    if l:normal == 0
      return "\<C-u>\<CR>"
    endif
  elseif l:line =~# '^\s*\d\+\. $'
    if l:normal == 0
      return "\<C-u>\<C-u>\<CR>"
    endif
  elseif l:line =~# '^\s*- \[[x ]\] '
    return l:out . "- [ ] "
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
    if l:normal == 0
      let l:out = "\<Esc>"
    else
      let l:out = ""
    endif
    if a:trigger ==# 'O'
      return l:out . "\"tyy\"tPf \"_Dmt:+1,'}normal! \<C-v>\<C-a>\<CR>'tA "
    else
      return l:out . "\"tyy\"tpf \"_Dmt:.,'}normal! \<C-v>\<C-a>\<CR>'tA "
    endif
  endif

  return a:trigger
endfunction

function! markdown#InsertDashes()
  " Do nothing special if text other than the inserted dashes is present on
  " the current line
  if col('$') > 4
    return '---'
  endif

  " On first line, insert YAML frontmatter
  if line('.') == 1
    return "---\<CR>---\<Up>"
  " Below empty line, insert horizontal rule
  elseif getline(line('.') - 1) ==# ''
    let len = &textwidth ? &textwidth : 10
    return repeat('-', len)
  endif

  " Else underline previous line
  return "\<Esc>kyypVr-a"
endfunction

" The gx mapping provided by the Netrw plug-in only works on WORDS. This
" provides support for opening links under the cursor:
function! markdown#FollowLinkUnderCursor()
  let l:saved_reg = @t
  let l:saved_pos = getpos('.')

  normal! Bf("tyib
  let l:url = @t
  call netrw#NetrwBrowseX(url, 0)

  let @t = l:saved_reg
  call setpos('.', l:saved_pos)
endfunction
