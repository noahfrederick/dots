" autoload/snippet_helper.vim - Global helpers for snippets
" Maintainer:   Noah Frederick

if exists("g:loaded_snippet_helper") || v:version < 700 || &cp
  finish
endif
let g:loaded_snippet_helper = 1

function! snippet_helper#Author()
  return system('git config --get user.name')[0:-2]
endfunction

function! snippet_helper#Email()
  return system('git config --get user.email')[0:-2]
endfunction

function! snippet_helper#Title(basename)
  if exists("g:template_title")
    " Setting g:template_title let's us override the title (once)
    title = g:template_title
    unlet g:template_title
    return title
  endif
  if exists("b:template_title")
    " Setting b:template_title also let's us override the title
    return b:template_title
  endif
  " Otherwise derive from file's basename
  let title = substitute(a:basename, '\C\(\l\)\(\u\|\d\)', '\1_\l\2', 'g')
  let title = substitute(title, '^.', '\u&', 'g')
  let title = substitute(title, '_\(.\)', ' \u\1', 'g')
  return title
endfunction

function! snippet_helper#ProjectTitle()
  if exists("$PROJECT_TITLE") && $PROJECT_TITLE != ""
    return $PROJECT_TITLE
  endif
  return "(Project Title)"
endfunction

" vim:set et sw=2:

