" after/ftplugin/markdown.vim - Markdown file-type settings

runtime! after/ftplugin/text.vim

" Turn on concealing of bold, italic markers
set conceallevel=2
set concealcursor=nc

" Org-mode-like extensions to Markdown

if exists(':Switch')
  let b:switch_custom_definitions = [
    \   {
    \     '^\(\s*[-+\*]\) TODO \(.*\)': '\1 DONE \2',
    \     '^\(\s*[-+\*]\) DONE \(.*\)': '\1 WAITING \2',
    \     '^\(\s*[-+\*]\) WAITING \(.*\)': '\1 CANCELED \2',
    \     '^\(\s*[-+\*]\) CANCELED \(.*\)': '\1 \2',
    \     '^\(\s*[-+\*]\) \%(TODO\|DONE\|WAITING\|CANCELED\|\[[ x]\]\)\@!\(.*\)': '\1 TODO \2',
    \   },
    \   {
    \     '^\(\s*\)-- \(.*\)': '\1++ \2',
    \     '^\(\s*\)++ \(.*\)': '\1-- \2',
    \   },
    \   {
    \     '^\(\s*[-+\*]\) \[ \] \(.*\)': '\1 [x] \2',
    \     '^\(\s*[-+\*]\) \[x\] \(.*\)': '\1 [ ] \2',
    \   },
    \ ]

  nnoremap <buffer> <CR> :Switch<CR>
endif

" Timestamp insertion
inoremap <buffer> <C-g>. [<C-r>=strftime("%Y-%m-%d %a")<CR>]
inoremap <buffer> <C-g>! [<C-r>=strftime("%Y-%m-%d %a %H:%M")<CR>]

" Promote/demote headings
nnoremap <buffer> <Left> :call markdown#PromoteHeading()<CR>
nnoremap <buffer> <Right> :call markdown#DemoteHeading()<CR>

" Follow link under cursor
nnoremap <buffer> gx :call markdown#FollowLinkUnderCursor()<CR>

" Smart dashes
iabbrev <buffer><expr> --- markdown#InsertDashes()

" Use pandoc to run off a PDF with :make
silent! compiler pandoc

" Recompile file on save if compiled version already exists
augroup AfterMarkdown
  autocmd!
  autocmd BufWritePost *.md call nox#make#Recompile(expand('<afile>'))
augroup END

" vim: fdm=marker:sw=2:sts=2:et
