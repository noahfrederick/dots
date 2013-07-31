" autoload/helper/snippets.vim - Global helpers for snippets
" Maintainer:   Noah Frederick

function! helper#snippet#Author()
  if executable("git")
    return system('git config --get user.name')[0:-2]
  endif
endfunction

function! helper#snippet#Email()
  if executable("git")
    return system('git config --get user.email')[0:-2]
  endif
endfunction

function! helper#snippet#Title(basename)
  if exists("g:template_title")
    " Setting g:template_title let's us override the title (once)
    let title = g:template_title
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

function! helper#snippet#ProjectTitle()
  if exists("$PROJECT_TITLE") && $PROJECT_TITLE != ""
    return $PROJECT_TITLE
  endif
  return "(Project Title)"
endfunction

" vim:set et sw=2:

