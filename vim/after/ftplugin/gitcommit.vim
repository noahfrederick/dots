setlocal spell

" Smart <Enter> in insert mode
inoremap <buffer><expr> <CR> markdown#OpenLine("\<CR>")

" Also for normal mode o/O
nnoremap <buffer><expr> o markdown#OpenLine("o")
nnoremap <buffer><expr> O markdown#OpenLine("O")
