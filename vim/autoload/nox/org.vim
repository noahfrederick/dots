" autoload/nox/org.vim - Organizer and note-taking system
" Maintainer: Noah Frederick

if !exists('g:nox#org#repos')
  let g:nox#org#repos = { 'default': '~/Notes' }
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

function! nox#org#repos() abort
  return sort(keys(g:nox#org#repos))
endfunction

function! nox#org#complete_repos(A, L, P)
  return nox#org#filter_completions(nox#org#repos(), a:A)
endfunction

function! nox#org#notes() abort
  let notes = []

  for repo in nox#org#repos()
    let notes += nox#org#repo(repo).notes()
  endfor

  return notes
endfunction

function! nox#org#resolve(slug) abort
  let parts = split(a:slug, ':')
  let repo = len(parts) > 1 ? nox#org#repo(remove(parts, 0)) : nox#org#repo()
  return repo.note(parts[0])
endfunction

function! nox#org#repo(...) abort
  let name = get(a:000, 0, 'default')

  if !has_key(g:nox#org#repos, name)
    return s:error('repo does not exist: '.name)
  endif

  if !has_key(s:repos, name)
    let s:repos[name] = deepcopy(s:repo_prototype)
    let s:repos[name]._name = name
    let s:repos[name]._path = expand(get(g:nox#org#repos, name))
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
  return map(self.glob('*'), {idx, path -> self.slugify(path, prefix)})
endfunction

function! s:repo_slugify(path, prefix) dict abort
  let path = fnamemodify(a:path, ':p:r')
  let filename = substitute(path, '^'.self.path().'/', '', '')
  return a:prefix.filename
endfunction

call s:add_methods('repo', ['path', 'prefix', 'note', 'glob', 'notes', 'slugify'])

function! nox#org#filter_completions(candidates, A) abort
  let candidates = sort(copy(a:candidates))

  let filtered = filter(copy(candidates), {idx, val -> val[0:strlen(a:A)-1] ==# a:A})
  if !empty(filtered) | return filtered | endif

  let regex = substitute(a:A, '.', '[&].*', 'g')
  let filtered = filter(copy(candidates), {idx, val -> val =~# regex})
  return filtered
endfunction

" vim: fdm=marker:sw=2:sts=2:et
