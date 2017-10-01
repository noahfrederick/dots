" autoload/my/project.vim - Query project metadata from multiple sources
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

function! s:git_config_get(key) abort
  let dir = exists(":Git") == 2 ? fugitive#repo().dir() : $HOME
  let cd = exists('*haslocaldir') && haslocaldir() ? 'lcd' : 'cd'
  let cwd = getcwd()

  execute cd fnameescape(dir)
  let result = system("git config --get " . a:key)[0:-2]
  execute cd fnameescape(cwd)

  return result
endfunction

let s:strategies = {}

function! s:strategies.projectionist(key) abort
  if !exists("b:projectionist") || empty(b:projectionist)
    return ""
  endif

  let key = "project_" . a:key

  return get(projectionist#query(key), 0, ["", ""])[1]
endfunction

function! s:strategies.composer(key) abort
  if !exists("b:composer_root") || empty(b:composer_root)
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

function! s:try_all_strategies(key) abort
  for name in ['projectionist', 'composer', 'git']
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
function! my#project#get(key, ...) abort
  let default = get(a:000, 0, "[project-" . a:key . "]")
  let value = s:try_all_strategies(a:key)

  if value ==# "" && a:key ==# "copyright"
    let value = join(["©", strftime("%Y"), s:try_all_strategies("author")])
  endif

  return value ==# "" ? default : value
endfunction

""
" Get current buffer's project's root directory.
function! my#project#root() abort
  if exists("b:projectionist") && !empty(b:projectionist)
    return projectionist#path()
  endif

  if exists("b:git_dir") && !empty(b:git_dir)
    return fnamemodify(b:git_dir, ":h")
  endif

  return getcwd()
endfunction

" vim: fdm=marker:sw=2:sts=2:et
