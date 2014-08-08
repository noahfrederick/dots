" ultisnips_custom.vim - Custom UltiSnips settings
" Maintainer:   Noah Frederick

if exists("g:loaded_ultisnips_custom") || !exists("g:did_UltiSnips_plugin") || exists(":SkelEdit")
  finish
endif
let g:loaded_ultisnips_custom = 1

augroup ultisnips_custom
  autocmd!
  autocmd User ProjectionistActivate silent! call helper#snippet#InsertSkeleton(expand("%"), 1)
  autocmd BufNewFile * silent! call helper#snippet#InsertSkeleton(expand("<amatch>"), 0)
  autocmd BufEnter * execute "inoremap <silent> "
        \ . g:UltiSnipsExpandTrigger
        \ . " <C-r>=helper#snippet#ExpandSnippetOrCompleteMaybe()<CR>"
augroup END

" vim: fdm=marker:sw=2:sts=2:et
