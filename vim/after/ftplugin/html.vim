setlocal textwidth=120

" Delete attributes in current tag
nnoremap <buffer> <LocalLeader>da lF<f dt>

" Better Sparkup mappings
inoremap <buffer> <C-l> <C-g>u<C-o>:call sparkup#transform()<CR>
inoremap <buffer> <C-n> <C-g>u<C-o>:call sparkup#next()<CR>
inoremap <buffer> <C-p> <C-g>u<C-o>:call sparkup#prev()<CR>

call nox#filetype#make_xml_maps()

command! -nargs=0 -range=% -buffer Format <line1>,<line2>call nox#format#js_beautify()
