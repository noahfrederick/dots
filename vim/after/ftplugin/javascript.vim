command! -nargs=0 -range=% -buffer Format <line1>,<line2>call nox#format#JsBeautify()
