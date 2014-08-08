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

function! helper#snippet#ExpandSnippetOrCompleteMaybe()
  call UltiSnips#ExpandSnippetOrJump()

  if !exists("g:ulti_expand_or_jump_res")
    return "\<Tab>"
  endif

  if g:ulti_expand_or_jump_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      return "\<Tab>"
    endif
  endif

  return ""
endfunction

function! s:try_insert(skel)
  execute "normal! i_" . a:skel . "\<C-r>=UltiSnips#ExpandSnippet()\<CR>"

  if g:ulti_expand_res == 0
    silent! undo
  endif

  return g:ulti_expand_res
endfunction

function! helper#snippet#InsertSkeleton(filename, is_projection) abort
  " Abort on non-empty buffer or extant file
  if !(line('$') == 1 && getline('$') == '') || filereadable(a:filename)
    return
  endif

  if a:is_projection
    " Loop through projections with 'skeleton' key and try each one until the
    " snippet expands
    for [root, value] in projectionist#query('skeleton')
      if s:try_insert(value)
        return
      endif
    endfor
  endif

  " Try generic _skel template as last resort
  call s:try_insert("skel")
endfunction

" vim:set et sw=2:
