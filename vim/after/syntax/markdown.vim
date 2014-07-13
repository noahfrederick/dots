" Org-mode-like extensions to Markdown

" The keywords below are case-sensitive
syntax case match

syntax keyword markdownOrgTodo TODO
syntax keyword markdownOrgDone DONE
syntax keyword markdownOrgCanceled CANCELED
syntax keyword markdownOrgWaiting WAITING
syntax match markdownOrgTimestamp "\[\d\{4}-\d\{2}-\d\{2} .\{-}\]"

" Pandoc
syntax match markdownTitleBlock "%\%(\s\|$\)"

highlight default link markdownTitleBlock PreProc
highlight default link markdownOrgTodo Todo
highlight default link markdownOrgDone Comment
highlight default link markdownOrgCanceled markdownOrgDone
highlight default link markdownOrgWaiting markdownOrgTodo
highlight default link markdownOrgTimestamp Special
