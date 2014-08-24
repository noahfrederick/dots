" autoload/vim.vim - Vim script helpers

let s:script_types = [
      \ "plugin",
      \ "ftplugin",
      \ "autoload",
      \ "syntax",
      \ "indent",
      \ "compiler",
      \ "t",
      \ ]

function! s:is_type(type, path)
  return (stridx(a:path . "/", a:type) != -1)
endfunction

function! vim#GuessFunctionPrefix(path)
  if s:is_type("autoload", a:path)
    let l:path = strpart(a:path, stridx(a:path, "autoload/") + strlen("autoload/"))
    return substitute(fnamemodify(l:path, ":r"), '/', '#', 'g') . "#"
  endif
  return "s:"
endfunction

function! vim#Modeline()
  return 'vim: fdm=marker:sw=2:sts=2:et'
endfunction

" vim: fdm=marker:sw=2:sts=2:et
