" autoload/nox/org/capture.vim - Organizer and note-taking system
" Maintainer: Noah Frederick

if !exists('g:nox#org#capture#templates')
  let g:nox#org#capture#templates = {}
endif

""
" Throw error with {msg}.
function! s:throw(msg) abort
  let v:errmsg = 'org: '.a:msg
  throw v:errmsg
endfunction

""
" Display error with {msg}.
function! s:error(msg) abort
  redraw " Removes artifacts in echo area
  echohl ErrorMsg
  echomsg (a:msg =~# '^org: ' ? a:msg : 'org: '.a:msg)
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

let s:template_prototype = {}
let s:status_prototype = {}

function! nox#org#capture#template(name) abort
  let name = a:name
  let template = {}

  if has_key(g:nox#org#capture#templates, name)
    let template = g:nox#org#capture#templates[name]
  elseif !empty(name)
    let name = nox#org#fzf#guess(name, sort(keys(g:nox#org#capture#templates)))
    let template = get(g:nox#org#capture#templates, name, 0)
  endif

  if empty(template)
    return s:error('capture template does not exist: '.name)
  endif

  if has_key(template, 'extends')
    if !has_key(g:nox#org#capture#templates, template.extends)
      return s:error('parent capture template does not exist: '.template.extends)
    endif

    let parent = g:nox#org#capture#templates[template.extends]
    let template = extend(deepcopy(parent), deepcopy(template))
  endif

  let template._name = name
  return extend(deepcopy(s:template_prototype), deepcopy(template))
endfunction

function! nox#org#capture#it(template, ...) abort
  if type(a:template) == type({})
    let template = a:template
  elseif !empty(a:template)
    let template = nox#org#capture#template(a:template)
  else
    let template = nox#org#capture#template('default')
  endif

  if empty(template)
    return s:error('empty template object')
  endif

  let extend = get(a:000, 0, {})

  if !empty(extend)
    call extend(template, deepcopy(extend))
  endif

  try
    if !template.status.did_init
      call template.init()
    endif

    call template.render()
  catch /^org: validation:/
    return s:error(v:errmsg)
  catch /^org: capture interrupted/
    return s:interrupt()
  catch /^org: capture canceled/
    return s:cancel()
  endtry
endfunction

function! s:cancel() abort
  call a:context.status.cancel()
endfunction

function! s:interrupt() abort
  let context = nox#org#capture#context()

  call context.status.wait()
  let callback = context.status.callback

  if empty(callback)
    return s:error('no interrupt callback was registered')
  endif

  let func = remove(callback, 0)
  let args = remove(callback, 0)
  " Func is presumed to start an asynchronous job and should register
  " nox#org#capture#resume() as a callback passing the result as an argument.
  return call(func, args)
endfunction

function! nox#org#capture#context(...) abort
  if a:0 > 0
    let g:nox#org#capture#context = a:1
  endif

  return get(g:, 'nox#org#capture#context', {})
endfunction

function! nox#org#capture#cancel() abort
  call s:throw('capture canceled')
endfunction

function! nox#org#capture#wait(...) abort
  let context = nox#org#capture#context()

  if context.status.is_waiting()
    call context.status.resume()
    return context.status.callback_result
  endif

  let context.status.callback = copy(a:000)
  call s:throw('capture interrupted')
endfunction

function! nox#org#capture#resume(result) abort
  let context = nox#org#capture#context()
  if empty(context)
    return s:error('nothing to resume')
  endif

  let context.status.callback_result = a:result
  return nox#org#capture#it(context)
endfunction

function! nox#org#capture#complete_slugs(A, L, P) abort
  let context = nox#org#capture#context()
  if empty(context) || context.status.did_terminate || nox#org#template#has_placeholders(context.repo)
    let slugs = nox#org#notes('')
  else
    let slugs = nox#org#repo(context.repo).notes('')
  endif
  return nox#org#filter_completions(slugs, a:A)
endfunction

function! nox#org#capture#complete_templates(A, L, P) abort
  return nox#org#filter_completions(keys(g:nox#org#capture#templates), a:A)
endfunction

let s:template_prototype.repo = 'default'
let s:template_prototype.slug = '{input:note name > ::slug|slugify}'
let s:template_prototype.path = '{repo:{repo}:{slug}}'
let s:template_prototype.template = []
let s:template_prototype.edit_command = '-tabedit'
let s:template_prototype.append = '$'
let s:template_prototype._clipboard = ''
let s:template_prototype._name = ''

function! s:template_init() dict abort
  call nox#org#capture#context(self)
  call self._normalize_properties()
  call self.status.set_header(self._name, self.path)
  call self.status.init()
endfunction

function! s:template_render() dict abort
  call self._expand_properties()
  call self._make_buffer()
  call self._insert()
  call self.status.complete()
endfunction

function! s:template__normalize_properties() dict abort
  " Normalize 'template' to a list
  if type(self.template) == type('')
    let self.template = [self.template]
  endif
endfunction

function! s:template__expand_property(key) dict abort
  if !has_key(self, a:key)
    call s:throw('validation: property does not exist: '.a:key)
  endif

  if type(self[a:key]) == type([])
    " Must be done in a loop so that intermediate states are preserved when
    " the capture process is interrupted.
    let i = 0
    for item in self[a:key]
      while nox#org#template#has_placeholders(self[a:key][i])
        silent call self.status.log('Doing expansion on: '.a:key)
        try
          let self[a:key][i] = nox#org#template#expand(self[a:key][i], self)
        catch /^org: expand property/
          " Encountered reference to unexpanded property.
          call self._expand_property(self._expanding)
        endtry
      endwhile
      let i += 1
    endfor
  elseif type(self[a:key]) == type('')
    while nox#org#template#has_placeholders(self[a:key])
      silent call self.status.log('Doing expansion on: '.a:key)
      try
        let self[a:key] = nox#org#template#expand(self[a:key], self)
      catch /^org: expand property/
        " Encountered reference to unexpanded property.
        call self._expand_property(self._expanding)
      endtry
    endwhile
  else
    call s:throw('cannot expand property: unsupported type')
  endif

  return self[a:key]
endfunction

function! s:template__expand_properties() dict abort
  call self._expand_property('path')

  if empty(self.path)
    call s:throw('validation: path is required')
  endif

  call self._expand_property('template')
endfunction

call s:add_methods('template', ['init', 'render', '_normalize_properties', '_expand_property', '_expand_properties'])

function! s:template__make_buffer() dict abort
  execute self.edit_command self.path
endfunction

function! s:template__insert() dict abort
  " Jump to line
  execute 'keeppatterns' self.append

  let text = copy(self.template)

  if !empty(self._clipboard)
    call add(text, "\n".self._clipboard)
  endif

  if !empty(text)
    call append(line('.'), text)

    " Move to first line of inserted text
    if line('.') > 1 && (line('$') - line('.')) > 1
      +2
    endif

    while line('$') > 1 && getline(1) ==# ''
      keepjumps 1delete
    endwhile
  endif

  silent! normal! zzzO
endfunction

call s:add_methods('template', ['_make_buffer', '_insert'])

function! s:template_prop(key) dict abort
  if nox#org#template#has_placeholders(self[a:key])
    " Cannot expand in place because of Vim script bug(?)
    let self._expanding = a:key
    throw 'org: expand property'
  endif

  return self._expand_property(a:key)
endfunction

function! s:template_has_prop(key) dict abort
  return (has_key(self, a:key) && type(self[a:key]) == type(''))
endfunction

call s:add_methods('template', ['prop', 'has_prop'])

let s:status_prototype._bufname = '[capture]'
let s:status_prototype._header = ''
let s:status_prototype._log = []
let s:status_prototype.callback = []
let s:status_prototype.did_init = 0
let s:status_prototype.did_wait = 0
let s:status_prototype.did_resume = 0
let s:status_prototype.did_cancel = 0
let s:status_prototype.did_complete = 0
let s:status_prototype.did_terminate = 0

function! s:status_init() dict abort
  let self.did_init += 1
  silent call self.log('Did init', self.did_init)
  return self.did_init
endfunction

function! s:status_wait() dict abort
  let self.did_wait += 1
  silent call self.log('Did wait', self.did_wait)
  return self.did_wait
endfunction

function! s:status_is_waiting() dict abort
  return self.did_wait > self.did_resume
endfunction

function! s:status_resume() dict abort
  let self.did_resume += 1
  silent call self.log('Did resume', self.did_resume)
  return self.did_resume
endfunction

function! s:status_cancel() dict abort
  let self.did_cancel += 1
  let self.did_terminate += 1
  silent call self.log('Did cancel', self.did_cancel)
  return self.did_cancel
endfunction

function! s:status_complete() dict abort
  let self.did_complete += 1
  let self.did_terminate += 1
  silent call self.log('Did complete', self.did_complete)
  return self.did_complete
endfunction

call s:add_methods('status', ['init', 'wait', 'is_waiting', 'resume', 'cancel', 'complete'])

function! s:status_log(msg, ...) dict abort
  redir => entry
  echo a:msg
  for item in a:000
    PP item
  endfor
  redir END

  return add(self._log, entry)
endfunction

call s:add_methods('status', ['log'])

function! s:status_buffer_setup() dict abort
  execute '-tabedit' self._bufname

  nohlsearch
  setlocal buftype=nofile bufhidden=wipe
  setfiletype capture.markdown

  nnoremap <buffer> q :bdelete<CR>
endfunction

call s:add_methods('status', ['buffer_setup'])

function! s:status_set_header(name, path) dict abort
  let self._header = self._format_header(a:name, a:path)
endfunction

function! s:status_print_header() dict abort
  call append(0, '# '.self._header)
endfunction

function! s:status__format_header(name, path) dict abort
  return printf('CAPTURE [%s] → %s', a:name, a:path)
endfunction

call s:add_methods('status', ['print_header', 'set_header', '_format_header'])

let s:template_prototype.status = s:status_prototype

" vim: fdm=marker:sw=2:sts=2:et
