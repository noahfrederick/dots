" autoload/my/org.vim - Organizer and note-taking system
" Maintainer: Noah Frederick

if !exists('g:my#org#repos')
  let g:my#org#repos = { 'default': '~/Notes' }
endif

let s:repos = {}
let s:ext = '.md'
let s:repo_delimiter = ':'

""
" Display error message
function! s:error(msg) abort
  echohl ErrorMsg
  echomsg 'org: '.a:msg
  echohl NONE
endfunction

""
" Get Funcref from script-local function {name}.
function! s:function(name) abort
  return function(substitute(a:name, '^s:', matchstr(expand('<sfile>'), '<SNR>\d\+_'), ''))
endfunction

""
" Add {method_names} to prototype {namespace} Dict.
function! s:add_methods(namespace, method_names) abort
  for name in a:method_names
    let s:{a:namespace}_prototype[name] = s:function('s:' . a:namespace . '_' . name)
  endfor
endfunction

let s:repo_prototype = {}

function! my#org#repos() abort
  return sort(keys(g:my#org#repos))
endfunction

function! my#org#complete_repos(A, L, P)
  return my#org#filter_completions(my#org#repos(), a:A)
endfunction

function! my#org#notes() abort
  let notes = []

  for repo in my#org#repos()
    let notes += my#org#repo(repo).notes()
  endfor

  return notes
endfunction

function! my#org#resolve(slug) abort
  let parts = split(a:slug, ':')
  let repo = len(parts) > 1 ? my#org#repo(remove(parts, 0)) : my#org#repo()
  return repo.note(parts[0])
endfunction

function! my#org#repo(...) abort
  let name = get(a:000, 0, 'default')

  if !has_key(g:my#org#repos, name)
    return s:error('repo does not exist: '.name)
  endif

  if !has_key(s:repos, name)
    let s:repos[name] = deepcopy(s:repo_prototype)
    let s:repos[name]._name = name
    let s:repos[name]._path = expand(get(g:my#org#repos, name))
  endif

  return s:repos[name]
endfunction

function! s:repo_path(...) dict abort
  let components = [self._path] + a:000
  call filter(components, {idx, val -> !empty(val)})
  return join(components, '/')
endfunction

function! s:repo_prefix() dict abort
  return self._name ==# 'default' ? '' : self._name.s:repo_delimiter
endfunction

function! s:repo_note(...) dict abort
  return call(self.path, a:000, self).s:ext
endfunction

function! s:repo_glob(pattern) dict abort
  return glob(self.note(a:pattern), 1, 1)
endfunction

function! s:repo_notes(...) dict abort
  let prefix = get(a:000, 0, self.prefix())
  return map(self.glob('**/*'), {idx, path -> self.slugify(path, prefix)})
endfunction

function! s:repo_slugify(path, prefix) dict abort
  let path = fnamemodify(a:path, ':p:r')
  let filename = substitute(path, '^'.self.path().'/', '', '')
  return a:prefix.filename
endfunction

call s:add_methods('repo', ['path', 'prefix', 'note', 'glob', 'notes', 'slugify'])

function! my#org#filter_completions(candidates, A) abort
  let candidates = sort(copy(a:candidates))

  let filtered = filter(copy(candidates), {idx, val -> val[0:strlen(a:A)-1] ==# a:A})
  if !empty(filtered) | return filtered | endif

  let regex = substitute(a:A, '.', '[&].*', 'g')
  let filtered = filter(copy(candidates), {idx, val -> val =~# regex})
  return filtered
endfunction

" vim: fdm=marker:sw=2:sts=2:et
