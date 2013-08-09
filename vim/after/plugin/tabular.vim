" after/plugin/tabular.vim - Custom presets for Tabular

if !exists(":Tabularize")
  finish
endif

AddTabularPattern! rocket /=>
AddTabularPattern! colon /:\zs

" Shortcuts for Tabular plug-in
nnoremap <Leader>a= :Tabularize /=<CR>
xnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize colon<CR>
xnoremap <Leader>a: :Tabularize colon<CR>
nnoremap <Leader>aw :Tabularize multiple_spaces<CR>
xnoremap <Leader>aw :Tabularize multiple_spaces<CR>
nnoremap <Leader>ar :Tabularize rocket<CR>
xnoremap <Leader>ar :Tabularize rocket<CR>
nnoremap <Leader>as :Tabularize assignment<CR>
xnoremap <Leader>as :Tabularize assignment<CR>

" vim:set et sw=2:
