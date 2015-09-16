setlocal foldmethod=marker
setlocal foldmarker={,}

call nox#filetype#MakeSemicolonMaps()

iabbrev <buffer> bq  blockquote
iabbrev <buffer> inb inline-block
iabbrev <buffer> inh inherit
iabbrev <buffer> inl inline
iabbrev <buffer> no  none
iabbrev <buffer> nr  no-repeat
iabbrev <buffer> rx  repeat-x
iabbrev <buffer> ry  repeat-y

command! -nargs=0 -range=% -buffer Format <line1>,<line2>call nox#format#JsBeautify()
