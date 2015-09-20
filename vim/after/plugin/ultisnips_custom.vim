" ultisnips_custom.vim - Custom UltiSnips settings
" Maintainer:   Noah Frederick

if exists(":SkelEdit") || !exists("g:UltiSnipsExpandTrigger") || !has("python") && !has("python3")
  finish
endif

augroup ultisnips_custom
  autocmd!
  autocmd BufNewFile * silent! call nox#snippet#insert_skeleton()
  autocmd BufEnter * execute "inoremap <silent> "
        \ . g:UltiSnipsExpandTrigger
        \ . " <C-r>=nox#snippet#expand_snippet_or_complete_maybe()<CR>"
augroup END

" vim: fdm=marker:sw=2:sts=2:et
