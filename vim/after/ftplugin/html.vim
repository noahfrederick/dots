setlocal textwidth=120

" Delete attributes in current tag
nnoremap <buffer> <LocalLeader>da lF<f dt>

call nox#filetype#make_sparkup_maps()
call nox#filetype#make_xml_maps()

command! -nargs=0 -range=% -buffer Format <line1>,<line2>call nox#format#js_beautify()
