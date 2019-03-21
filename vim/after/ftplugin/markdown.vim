" after/ftplugin/markdown.vim - Markdown file-type settings

runtime! after/ftplugin/text.vim

" Turn on concealing of bold, italic markers
setlocal conceallevel=2

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
nnoremap <buffer> g<Left> :call my#markdown#promote_heading()<CR>
nnoremap <buffer> g<Right> :call my#markdown#demote_heading()<CR>

" Navigate links
nnoremap <buffer> <C-n> :call my#markdown#next_link()<CR>
nnoremap <buffer> <C-p> :call my#markdown#previous_link()<CR>
nnoremap <buffer> gx :call my#markdown#follow_link_under_cursor()<CR>

" Insert links
nnoremap <buffer> gl "lciw[<C-r>l]()<Left>
inoremap <buffer> <C-l> <Esc>"lciw[<C-r>l]()<Left>
xnoremap <buffer> <C-l> "lc[<C-r>l]()<Left>
xmap <buffer> gl <C-l>

" Smart dashes
iabbrev <buffer><expr> --- my#markdown#insert_dashes()

" Use pandoc to run off a PDF with :make
silent! compiler pandoc

" Recompile file on save if compiled version already exists
augroup markdown_after
  autocmd!
  autocmd BufWritePost *.md call my#make#recompile(expand('<afile>'))
augroup END

" vim: fdm=marker:sw=2:sts=2:et
