" autoload/my/org/protocol.vim - Organizer and note-taking system
" Maintainer: Noah Frederick

""
" Display error with {msg}.
function! s:error(msg) abort
  echohl ErrorMsg
  echomsg 'org-protocol: '.a:msg
  echohl NONE
endfunction

function! my#org#protocol#capture(url) abort
  let bufnr = bufnr('%')
  buffer #
  execute 'bwipeout' bufnr

  let url = s:parse(a:url)

  " Work around stupid problem with cursor not being in the right window
  " when capture needs user input before VimEnter.
  if v:vim_did_enter
    call my#org#capture#it(url.path, url.querystring)
  else
    let g:my#org#protocol#url = url
    autocmd org VimEnter *
          \ call my#org#capture#it(g:my#org#protocol#url.path, g:my#org#protocol#url.querystring) |
          \ unlet! g:my#org#protocol#url
  endif
endfunction

function! s:parse(url) abort
  let url = {}
  let url.protocol = matchstr(a:url, '^\w\+:\ze//')
  let url.path = matchstr(a:url, '//\zs[^?#]\+')
  let url.querystring = s:parse_querystring(matchstr(a:url, '?\zs[^#]\+'))
  let url.fragment = matchstr(a:url, '#\zs.*$')
  return url
endfunction

function! s:parse_querystring(querystring) abort
  let items = split(a:querystring, '&')
  let querystring = {}

  for item in items
    let parts = split(item, '=')
    let querystring[parts[0]] = get(parts, 1, '')
  endfor

  return querystring
endfunction

" vim: fdm=marker:sw=2:sts=2:et
