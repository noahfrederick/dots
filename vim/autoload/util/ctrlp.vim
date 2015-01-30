" autoload/util/ctrlp.vim - CtrlP helpers
" Maintainer:   Noah Frederick

" ctrlp#Statusline1 and ctrlp#Statusline2 both must return a full statusline
" and are accessible globally.

" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"            a:1    a:2      a:3       a:4  a:5   a:6  a:7
function! util#ctrlp#Statusline1(...)
  let separator_left = " \u27e9 "
  let separator_right = " \u27e8 "

  let usercolor = "%4*"
  if a:5 == "buffers"
    let usercolor = "%5*"
  elseif a:5 == "mru files"
    let usercolor = "%6*"
  elseif a:5 == "bookmarked dirs"
    let usercolor = "%7*"
  elseif a:5 == "tags"
    let usercolor = "%8*"
  elseif a:5 == "runtime scripts"
    let usercolor = "%9*"
  endif

  let byfname = usercolor." ".a:2.separator_left
  let dir = getcwd().separator_left
  let marked = a:7[2:-2]."%="

  let regex = a:3 ? "regex".separator_right : ""
  let focus = a:1.separator_right
  let prv = a:4." "
  let item = "%#StatusLine# ".a:5." ".usercolor
  let nxt = " ".a:6." "

  " Return the full statusline
  return byfname.dir.marked.regex.focus.prv.item.nxt
endfunction

" Argument: len
"           a:1
function! util#ctrlp#Statusline2(...)
  return " ".getcwd()." %= ".a:1." "
endfunction
