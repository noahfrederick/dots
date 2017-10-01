setlocal foldmethod=marker
setlocal foldmarker={,}

call my#filetype#make_semicolon_maps()

iabbrev <buffer> bq  blockquote
iabbrev <buffer> inb inline-block
iabbrev <buffer> inh inherit
iabbrev <buffer> inl inline
iabbrev <buffer> no  none
iabbrev <buffer> nr  no-repeat
iabbrev <buffer> rx  repeat-x
iabbrev <buffer> ry  repeat-y

command! -nargs=0 -range=% -buffer Format <line1>,<line2>call my#format#js_beautify()
