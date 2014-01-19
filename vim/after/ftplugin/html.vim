" Delete attributes in current tag
nnoremap <buffer> <LocalLeader>da lF<f dt>

" Better Sparkup mappings
inoremap <buffer> <C-l> <C-g>u<C-o>:call sparkup#transform()<CR>
inoremap <buffer> <C-n> <C-g>u<C-o>:call sparkup#next()<CR>
inoremap <buffer> <C-p> <C-g>u<C-o>:call sparkup#prev()<CR>
