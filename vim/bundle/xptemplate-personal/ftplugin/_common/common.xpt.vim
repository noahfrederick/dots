XPTemplate priority=personal+

" containers
let s:f = g:XPTfuncs()

fun! s:f.year(...) "{{{
  return strftime('%Y')
endfunction "}}}

XPT copyright " © 2013 Noah Frederick
© `year()^ `$author^
