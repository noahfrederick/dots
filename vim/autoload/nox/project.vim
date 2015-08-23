" autoload/nox/project.vim - Query project metadata from multiple sources
" Maintainer: Noah Frederick
"
" Common keys to query:
" - title
" - author
" - email
" - license
" - copyright
" - github
"
" These strategies are used in order:
" - Projectionist
" - TODO: Vim Addon Manager (VAM)
" - Composer
" - TODO: Ruby Gems
" - TODO: Bower
" - Git
" - Use a placeholder

function! s:git_config_get(key) abort
  if exists(":Git")
    let dir = fugitive#repo().dir()
    return system("cd " . dir . " && git config --get " . a:key)[0:-2]
  else
    return system("git config --get " . a:key)[0:-2]
  endif
endfunction

let s:strategies = {}

function! s:strategies.projectionist(key) abort
  if empty(b:projectionist)
    return ""
  endif

  let key = "project_" . a:key

  return get(projectionist#query(key), 0, ["", ""])[1]
endfunction

function! s:strategies.composer(key) abort
  if empty(b:composer_root)
    return ""
  endif

  if a:key ==# "title"
    return composer#query("name")
  elseif a:key ==# "author"
    let authors = composer#query("authors")
    if authors !=# ""
      return join(map(authors, "get(v:val, 'name')"), ", ")
    endif
  endif

  return composer#query(a:key)
endfunction

function! s:strategies.git(key) abort
  if !executable("git")
    return ""
  endif

  let key = a:key
  let value = s:git_config_get("project." . key)

  if value == ""
    if key == "author"
      let key = "name"
    endif

    let value = s:git_config_get("user." . key)
  endif

  return value
endfunction

function! s:strategies.placeholder(key) abort
  return "[project-" . a:key . "]"
endfunction

function! s:try_all_strategies(key) abort
  for name in ['projectionist', 'composer', 'git', 'placeholder']
    let Strat = s:strategies[name]
    let value = call(Strat, [a:key], {})

    if value != ""
      return value
    endif
  endfor

  return ""
endfunction

""
" Query current buffer's project metadata by key.
function! nox#project#get(key) abort
  let value = s:try_all_strategies(a:key)

  if value == "[project-copyright]"
    let value = join(["©", strftime("%Y"), s:try_all_strategies("author")])
  endif

  return value
endfunction

""
" Get current buffer's project's root directory.
function! nox#project#root() abort
  if !empty(b:projectionist)
    return projectionist#path()
  endif

  if !empty(b:git_dir)
    return fnamemodify(b:git_dir, ":h")
  endif

  return getcwd()
endfunction

" vim: fdm=marker:sw=2:sts=2:et
