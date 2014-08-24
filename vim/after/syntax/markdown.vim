" Org-mode-like extensions to Markdown

" The keywords below are case-sensitive
syntax case match

syntax keyword markdownOrgTodo TODO
syntax keyword markdownOrgDone DONE
syntax keyword markdownOrgCanceled CANCELED
syntax keyword markdownOrgWaiting WAITING
syntax match markdownOrgTimestamp "\[\d\{4}-\d\{2}-\d\{2} .\{-}\]"

if has('conceal')
  if &termencoding ==# "utf-8" || &encoding ==# "utf-8"
    " Checkboxes
    " let s:checkbox_unchecked = "\u2611"
    " let s:checkbox_checked = "\u2612"
    " Bullets
    let s:checkbox_unchecked = "\u25cb"
    let s:checkbox_checked = "\u25cf"
  else
    let s:checkbox_unchecked = 'o'
    let s:checkbox_checked = 'x'
  endif
  syntax match markdownCheckbox "^\s*\([-\*] \[[ x]\]\|--\|++\) " contains=markdownCheckboxChecked,markdownCheckboxUnchecked
  execute 'syntax match markdownCheckboxUnchecked "\([-\*] \[ \]\|--\)" contained conceal cchar='.s:checkbox_unchecked
  execute 'syntax match markdownCheckboxChecked "\([-\*] \[x\]\|++\)" contained conceal cchar='.s:checkbox_checked
endif

" Pandoc
syntax match markdownTitleBlock "%\%(\s\|$\)"

highlight default link markdownTitleBlock PreProc
highlight default link markdownOrgTodo Todo
highlight default link markdownOrgDone Comment
highlight default link markdownOrgCanceled markdownOrgDone
highlight default link markdownOrgWaiting markdownOrgTodo
highlight default link markdownOrgTimestamp Special
