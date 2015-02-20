" after/ftplugin/qf.vim - QuickFix filetype plug-in

nnoremap <buffer> q :quit<CR>

wincmd J

" Do not highlight current line in quickfix window as it overlaps the
" current item highlight
setlocal nowrap nocursorline nonumber nospell
setlocal nobuflisted

let &l:statusline  = " %q "
let &l:statusline .= "%#StatusLineNC#"
let &l:statusline .= "%{exists('w:quickfix_title') ? w:quickfix_title : ''}"
let &l:statusline .= "%*"
let &l:statusline .= "%="
let &l:statusline .= "%l of %L "

let b:undo_ftplugin = "set statusline<"

" vim: fdm=marker:sw=2:sts=2:et
