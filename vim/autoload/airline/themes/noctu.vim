" vim-airline companion theme of Noctu/Styx

function! s:generate()
  " Here are examples where the entire highlight group is copied and an airline
  " compatible color array is generated.
  let s:N1 = airline#themes#get_highlight('User1')
  let s:N2 = airline#themes#get_highlight('User2')
  let s:N3 = airline#themes#get_highlight('StatusLine')
  let s:N4 = airline#themes#get_highlight('String')

  " The file indicator is a special case where if the background values are
  " empty the generate_color_map function will extract a matching color.
  let s:file = airline#themes#get_highlight('Constant')
  let s:file[1] = ''
  let s:file[3] = ''

  let g:airline#themes#noctu#normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3, s:file)
  let g:airline#themes#noctu#normal_modified = { 'statusline': s:N4 }

  let s:I1 = airline#themes#get_highlight('User3')
  let s:I2 = s:N2
  let s:I3 = s:N3
  let g:airline#themes#noctu#insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3, s:file)
  let g:airline#themes#noctu#insert_modified = g:airline#themes#noctu#normal_modified

  let s:R1 = airline#themes#get_highlight('User4')
  let s:R2 = s:N2
  let s:R3 = s:N3
  let g:airline#themes#noctu#replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3, s:file)
  let g:airline#themes#noctu#replace_modified = g:airline#themes#noctu#normal_modified

  let s:V1 = airline#themes#get_highlight('User5')
  let s:V2 = s:N2
  let s:V3 = s:N3
  let g:airline#themes#noctu#visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3, s:file)
  let g:airline#themes#noctu#visual_modified = g:airline#themes#noctu#normal_modified

  let s:IA = airline#themes#get_highlight('StatusLineNC')
  let g:airline#themes#noctu#inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA, s:file)

  if get(g:, 'loaded_ctrlp', 0)
    let s:C1 = airline#themes#get_highlight('User6')
    let s:C2 = airline#themes#get_highlight('User7')
    let s:C3 = airline#themes#get_highlight('Wildmenu')
    let g:airline#themes#noctu#ctrlp = airline#extensions#ctrlp#generate_color_map(s:C1, s:C2, s:C3)
  endif
endfunction

call s:generate()
augroup airline_noctu
  autocmd!
  autocmd ColorScheme * call <SID>generate()
augroup END
