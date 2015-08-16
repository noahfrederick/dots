setlocal foldmethod=marker
setlocal foldmarker={,}

call nox#filetype#MakeSemicolonMaps()

command! -nargs=0 -range=% -buffer Format <line1>,<line2>call nox#format#JsBeautify()
