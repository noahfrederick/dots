" after/ftplugin/text.vim - Text file-type settings

if &modifiable
  setlocal spell
  setlocal comments=

  " Smart <Enter> in insert mode
  inoremap <buffer><expr> <CR> my#markdown#open_line("\<CR>")

  " Also for normal mode o/O
  nnoremap <buffer><expr> o my#markdown#open_line("o")
  nnoremap <buffer><expr> O my#markdown#open_line("O")

  if exists(":Abolish")
    Abolish -buffer Bb Bitbucket
    Abolish -buffer Gh GitHub
    Abolish -buffer Im I'm
    Abolish -buffer Tw Teamwork
    Abolish -buffer Wp WordPress
    Abolish -buffer eg e.g.,
    Abolish -buffer ie i.e.,
    Abolish -buffer plugin{,s} plug-in{}
    Abolish -buffer {he,here,she,that,there,where}s {}'s
    Abolish -buffer {I,we,you,they}ve {}'ve
    Abolish -buffer {is,was,do,does,did,would,could,should,wo,ca}nt {}n't
    Abolish -buffer {you,they}re {}'re
  endif

  command! -nargs=0 -range -bang Quote
        \ if <bang>0 |
        \   silent <line1>,<line2>substitute/^> //e |
        \ else |
        \   silent <line1>,<line2>substitute/^/> /e | silent <line1>,<line2>substitute/>\zs\s\+$//e |
        \ endif

  nnoremap <buffer><silent> <A-'> :Quote<CR>
  nnoremap <buffer><silent> <A-"> :Quote!<CR>

  xnoremap <buffer><silent> <A-'> :Quote<CR>gv
  xnoremap <buffer><silent> <A-"> :Quote!<CR>gv

  " Paste as block quote
  nnoremap <buffer><silent> <LocalLeader>p :put<Bar>:'[,']Quote<CR>
endif

command! -nargs=+ -range=% Count <line1>,<line2>substitute/<args>//ng

" vim: fdm=marker:sw=2:sts=2:et
