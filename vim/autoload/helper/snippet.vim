" autoload/helper/snippets.vim - Global helpers for snippets
" Maintainer:   Noah Frederick

function! helper#snippet#Author()
  if exists("$PROJECT_AUTHOR") && $PROJECT_AUTHOR != ""
    return $PROJECT_AUTHOR
  endif
  return s:get_git_config_value('user.name')
endfunction

function! helper#snippet#Email()
  if exists("$PROJECT_EMAIL") && $PROJECT_EMAIL != ""
    return $PROJECT_EMAIL
  endif
  return s:get_git_config_value('user.email')
endfunction

function! helper#snippet#GitHubUsername()
  if exists("$PROJECT_GITHUB_USERNAME") && $PROJECT_GITHUB_USERNAME != ""
    return $PROJECT_GITHUB_USERNAME
  endif
  return s:get_git_config_value('user.github')
endfunction

function! s:get_git_config_value(key)
  if executable("git")
    return system('git config --get ' . a:key)[0:-2]
  endif
  return 0
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

function! helper#snippet#Copyright()
  if exists("$PROJECT_COPYRIGHT") && $PROJECT_COPYRIGHT != ""
    let name = $PROJECT_COPYRIGHT
  else
    let name = helper#snippet#Author()
  endif
  return join(['©', strftime('%Y'), name])
endfunction

function! helper#snippet#ProjectTitle()
  if exists("$PROJECT_NAME") && $PROJECT_NAME != ""
    return $PROJECT_NAME
  endif
  return "(Project Name)"
endfunction

" vim:set et sw=2:
