" jekyll.vim - Jekyll blog helpers
" Maintainer:   Noah Frederick

if exists("g:loaded_jekyll") || !exists("$BLOG") || v:version < 700 || &cp
  finish
endif
let g:loaded_jekyll = 1

" Create a new Jekyll post in _drafts/
function! s:new_post(title, bang)
  let g:template_title = a:title
  let file = expand('$BLOG') . '/_drafts/' . tolower(substitute(a:title, '\W\+', '-', 'g')) . '.md'
  execute 'edit' . a:bang . ' ' . fnameescape(file)
  set filetype=liquid
endfunction

" Move the current draft into _posts/ and prepend date to filename
function! s:publish_post()
  if !exists(':Move')
    echoerr 'Requires eunuch-:Move command'
    return
  elseif expand('%:p:h') !~# '/_drafts$'
    echoerr 'This does not appear to be a draft blog post'
    return
  endif
  write
  exec 'Move ' . expand('$BLOG') . '/_posts/' . strftime('%Y-%m-%d') . '-' . expand('%:p:t')
endfunction

command! -nargs=1 -bang JekyllNew call <SID>new_post(<q-args>, <q-bang>)
command! -bar JekyllPublish call <SID>publish_post()

" vim: fdm=marker:sw=2:sts=2:et
