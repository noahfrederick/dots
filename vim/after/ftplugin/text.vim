" after/ftplugin/text.vim - Text file-type settings

if &modifiable
  setlocal spell

  " Smart <Enter> in insert mode
  inoremap <buffer><expr> <CR> markdown#OpenLine("\<CR>")

  " Also for normal mode o/O
  nnoremap <buffer><expr> o markdown#OpenLine("o")
  nnoremap <buffer><expr> O markdown#OpenLine("O")

  iabbrev <buffer> eg e.g.,
  iabbrev <buffer> ie i.e.,
endif

" vim: fdm=marker:sw=2:sts=2:et
