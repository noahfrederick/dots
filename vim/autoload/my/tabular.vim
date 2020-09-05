" autoload/my/tabular.vim - Tabular
" Maintainer: Noah Frederick

function! my#tabular#setup() abort
  AddTabularPattern! rocket /=>
  AddTabularPattern! colon  /:\zs /l0
  AddTabularPattern! comma  /,\zs /l0

  AddTabularPipeline! table /\|/
        \ map(a:lines, 'substitute(v:val, ''|-\+\ze|'', ''|'', ''g'')') |
        \ tabular#TabularizeStrings(a:lines, '|', 'l1') |
        \ map(a:lines, 'substitute(v:val, ''|\zs \+\ze|'', ''\=repeat("-", strlen(submatch(0)))'', ''g'')') |
        \ map(a:lines, 'substitute(v:val, ''^\s*'', '''', '''')')
endfunction

" vim: fdm=marker:sw=2:sts=2:et
