" https://github.com/chrisbra/csv.vim maps H and L to navigate columns.
" I find the original function to be more useful. Unfortunately, the plug-in
" maps to script-local functions directly, making remapping nearly impossible.
silent! unmap <buffer> H
silent! unmap <buffer> L
