setlocal foldmethod=marker
setlocal foldmarker={,}

call nox#filetype#MakeSemicolonMaps()

command! -nargs=0 -range=% -buffer JsBeautify <line1>,<line2>call nox#format#JsBeautify()
