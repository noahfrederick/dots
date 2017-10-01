" Delete attributes in current tag
nnoremap <buffer> <LocalLeader>da lF<f dt>

call my#filetype#make_sparkup_maps()
call my#filetype#make_xml_maps()

command! -nargs=0 -range=% -buffer Format <line1>,<line2>call my#format#js_beautify()
