XPTemplate priority=personal+

" containers
let s:f = g:XPTfuncs()

fun! s:f.year(...) "{{{
  return strftime('%Y')
endfunction "}}}

XPT copyright " (c) 2012 Noah Frederick
(c) `year()^ `$author^
