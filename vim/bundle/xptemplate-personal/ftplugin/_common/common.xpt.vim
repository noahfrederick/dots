XPTemplate priority=personal+

" containers
let s:f = g:XPTfuncs()

function! s:f.year(...)
  return strftime('%Y') " 3000
endfunction

function! s:f.prettyDate(...)
  return strftime('%B %e, %Y') " January 1, 3000
endfunction

XPT copyright " © 2013 Noah Frederick
© `year()^ `$author^

XPT date alias=Date
XPT now  alias=Date