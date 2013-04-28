" File: after/plugin/ctrlp.vim
" Description: Custom statusline

" Make sure ctrlp is installed and loaded
if !exists("g:loaded_ctrlp") || ( exists("g:loaded_ctrlp") && !g:loaded_ctrlp )
  finish
endif


" ctrlp only looks for this
let g:ctrlp_status_func = {
  \ "main": "CtrlP_Statusline_1",
  \ "prog": "CtrlP_Statusline_2",
  \ }


" CtrlP_Statusline_1 and CtrlP_Statusline_2 both must return a full statusline
" and are accessible globally.

" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"            a:1    a:2      a:3       a:4  a:5   a:6  a:7
function! CtrlP_Statusline_1(...)
  let usercolor = "%9*"
  if a:5 == "buffers"
    let usercolor = "%1*"
  elseif a:5 == "mru files"
    let usercolor = "%2*"
  endif

  let byfname = usercolor." ".a:2.g:statusline_separator_left
  let dir = getcwd().g:statusline_separator_left
  let marked = a:7[2:-2]."%="

  let regex = a:3 ? "regex".g:statusline_separator_right : ""
  let focus = a:1.g:statusline_separator_right
  let prv = a:4." "
  let item = "%4* ".a:5." ".usercolor
  let nxt = " ".a:6." "

  " Return the full statusline
  return byfname.dir.marked.regex.focus.prv.item.nxt
endfunction


" Argument: len
"           a:1
function! CtrlP_Statusline_2(...)
  return " ".getcwd()." %= ".a:1." "
endfunction
