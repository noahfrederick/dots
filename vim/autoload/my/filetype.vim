" autoload/my/filetype.vim - Global helpers for filetype plug-ins
" Maintainer:   Noah Frederick

" Determine if current 'filetype' contains filetype
function! my#filetype#(filetype) abort
  return ('.' . &filetype . '.' =~# '\.' . a:filetype . '\.')
endfunction

" Append additional file type using dot syntax
function! my#filetype#append(filetype) abort
  if !my#filetype#(a:filetype)
    let &filetype = &filetype . '.' . a:filetype
  endif
endfunction

" Append semicolon or comma to end of line in insert mode
function! my#filetype#make_semicolon_maps()
  call my#filetype#map("inoremap", ";;", "<Esc>A;")
  call my#filetype#map("inoremap", ",,", "<Esc>A,")
endfunction

" Insert "=>", "->", or "=" in Ruby/PHP buffers depending on context:
"
"   $foo |
"   $foo = |
"
"   $foo|
"   $foo->|
"
"   'bar'|
"   'bar' => |
"
function! s:rocket() abort
  let line = getline('.')
  let prev_char = matchstr(line, '\%' . (col('.') - 1) . 'c.')

  if line =~# '^\s*\$\?\k\+\s\+$'
    return '= '
  elseif prev_char =~# '\k\|)'
    return '->'
  elseif prev_char =~# '\s'
    return '=> '
  else
    return ' => '
  endif
endfunction

function! s:in_syntax(names) abort
  let groups = map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  for name in a:names
    if index(groups, name) >= 0
      return 1
    endif
  endfor
  return 0
endfunction

function! s:sparkup_or_rocket() abort
  if s:in_syntax(['phpFunction', 'phpIdentifier', 'phpRegion', 'bladeDelimiter', 'bladeEcho', 'bladePhpParenBlock'])
    return s:rocket()
  endif
  return "\<C-g>u\<C-o>:call sparkup#transform()\<CR>"
endfunction

function! my#filetype#make_rocket_maps()
  call my#filetype#map("inoremap", "<expr> <C-l>", "<SID>rocket()")
endfunction

function! my#filetype#make_sparkup_maps()
  call my#filetype#map("inoremap", "<expr> <C-l>", "<SID>sparkup_or_rocket()")
  call my#filetype#map("inoremap", "<C-S-n>", "<C-g>u<C-o>:call sparkup#next()<CR>")
  call my#filetype#map("inoremap", "<C-S-p>", "<C-g>u<C-o>:call sparkup#prev()<CR>")
endfunction

function! my#filetype#make_xml_maps()
  " Automatically close tags when typing "</"
  call my#filetype#map("inoremap", "</", "</<C-x><C-o><C-n><CR>")
endfunction

function! my#filetype#map(type, lhs, rhs)
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
