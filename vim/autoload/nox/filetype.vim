" autoload/nox/filetype.vim - Global helpers for filetype plug-ins
" Maintainer:   Noah Frederick

" Append semicolon or comma to end of line in insert mode
function! nox#filetype#make_semicolon_maps()
  call nox#filetype#map("inoremap", ";;", "<Esc>A;")
  call nox#filetype#map("inoremap", ",,", "<Esc>A,")
endfunction

" Insert "=>" or "->" depending on context
function! s:rocket() abort
  let prev_char = matchstr(getline('.'), '\%' . (col('.') - 1) . 'c.')
  if prev_char =~# '\k'
    return '->'
  elseif prev_char =~# '\s'
    return '=> '
  else
    return ' => '
  endif
endfunction

function! nox#filetype#make_rocket_maps()
  call nox#filetype#map("inoremap", "<expr> <C-l>", "<SID>rocket()")
endfunction

function! nox#filetype#make_xml_maps()
  " Automatically close tags when typing "</"
  call nox#filetype#map("inoremap", "</", "</<C-x><C-o>")
endfunction

function! nox#filetype#map(type, lhs, rhs)
  execute join([a:type, "<buffer>", a:lhs, a:rhs])

  if a:type == "nnoremap" || a:type == "nmap"
    let l:unmap = "nunmap"
  elseif a:type == "noremap" || a:type == "map"
    let l:unmap = "unmap"
  elseif a:type == "xnoremap" || a:type == "xmap"
    let l:unmap = "xunmap"
  elseif a:type == "vnoremap" || a:type == "vmap"
    let l:unmap = "vunmap"
  elseif a:type == "onoremap" || a:type == "omap"
    let l:unmap = "ounmap"
  elseif a:type == "inoremap" || a:type == "imap"
    let l:unmap = "iunmap"
  endif

  if !exists('b:undo_ftplugin')
    let b:undo_ftplugin = ''
  endif

  let b:undo_ftplugin .= join(["| silent!", l:unmap, "<buffer>", a:lhs])
endfunction

" vim:set et sw=2:
