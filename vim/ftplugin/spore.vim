" ftplugin/spore.vim - Spore plug-in manager buffer functionality
" Maintainer:   Noah Frederick

if has("conceal")
  set conceallevel=2
  set concealcursor=nvi
endif

setlocal statusline=[Spore]

nnoremap <buffer> <silent> r :silent call spore#refresh()<CR>
nnoremap <buffer> <silent> u :call spore#update(spore#current_bundle())<CR>
nnoremap <buffer> <silent> U :call spore#update_all()<CR>
nnoremap <buffer> <silent> R :call spore#restore(spore#current_bundle())<CR>
nnoremap <buffer> <silent> D :call spore#uninstall(spore#current_bundle())<CR>
nnoremap <buffer> q :quit!<CR>

nnoremap <buffer> i <Nop>
nnoremap <buffer> I <Nop>
nnoremap <buffer> a <Nop>
nnoremap <buffer> A <Nop>
nnoremap <buffer> o <Nop>
nnoremap <buffer> O <Nop>
nnoremap <buffer> c <Nop>
nnoremap <buffer> C <Nop>

" vim: fdm=marker:sw=2:sts=2:et
