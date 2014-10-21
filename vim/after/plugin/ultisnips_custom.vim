" ultisnips_custom.vim - Custom UltiSnips settings
" Maintainer:   Noah Frederick

if exists("g:loaded_ultisnips_custom") || !exists("g:did_UltiSnips_plugin") || exists(":SkelEdit")
      \ || !exists("python") && !exists("python3")
  finish
endif
let g:loaded_ultisnips_custom = 1

augroup ultisnips_custom
  autocmd!
  autocmd User ProjectionistActivate silent! call util#snippet#InsertSkeleton(expand("%"), 1)
  autocmd BufNewFile * silent! call util#snippet#InsertSkeleton(expand("<amatch>"), 0)
  autocmd BufEnter * execute "inoremap <silent> "
        \ . g:UltiSnipsExpandTrigger
        \ . " <C-r>=util#snippet#ExpandSnippetOrCompleteMaybe()<CR>"
augroup END

" vim: fdm=marker:sw=2:sts=2:et
