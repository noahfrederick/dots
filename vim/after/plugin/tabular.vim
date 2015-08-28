" after/plugin/tabular.vim - Custom patterns for Tabular

if !exists(":Tabularize")
  finish
endif

AddTabularPattern! rocket /=>
AddTabularPattern! colon  /:\zs /l0
AddTabularPattern! comma  /,\zs /l0

AddTabularPipeline! table /\|/
      \ map(a:lines, 'substitute(v:val, ''|\s*-\+\s*\ze|'', ''|'', ''g'')') |
      \ tabular#TabularizeStrings(a:lines, '|', 'l1') |
      \ map(a:lines, 'substitute(v:val, ''|\zs \+\ze|'', ''\=repeat("-", strlen(submatch(0)))'', ''g'')')

" Shortcuts for Tabular plug-in
nnoremap <Leader>a= :Tabularize /=<CR>
xnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize colon<CR>
xnoremap <Leader>a: :Tabularize colon<CR>
nnoremap <Leader>a, :Tabularize comma<CR>
xnoremap <Leader>a, :Tabularize comma<CR>
nnoremap <Leader>a<Bar> :Tabularize table<CR>
xnoremap <Leader>a<Bar> :Tabularize table<CR>
nnoremap <Leader>aa :Tabularize /
xnoremap <Leader>aa :Tabularize /
nnoremap <Leader>aw :Tabularize multiple_spaces<CR>
xnoremap <Leader>aw :Tabularize multiple_spaces<CR>
nnoremap <Leader>ar :Tabularize rocket<CR>
xnoremap <Leader>ar :Tabularize rocket<CR>
nnoremap <Leader>as :Tabularize assignment<CR>
xnoremap <Leader>as :Tabularize assignment<CR>

" vim: fdm=marker:sw=2:sts=2:et
