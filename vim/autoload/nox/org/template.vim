" autoload/nox/org/template.vim - Organizer and note-taking system
" Maintainer: Noah Frederick

let s:placeholder_regex = '{[^{}]\+}'
let s:completion_types = {'slug': 'customlist,nox#org#capture#complete_slugs'}

function! s:split(str, c) abort
  let str = substitute(a:str, a:c, '\r', 'g')
  let str = substitute(str, '\\\r', a:c, 'g')
  return split(str, '\r', 1)
endfunction

function! s:completion(type) abort
  return get(s:completion_types, a:type, a:type)
endfunction

function! s:input(prompt, default, completion) abort
  redraw " Let screen update before showing prompt
  echohl Question
  if a:completion
    let input = input(a:prompt, a:default, s:completion(a:completion))
  else
    let input = input(a:prompt, a:default)
  endif
  echohl NONE
  redraw
  return input
endfunction

if !exists('g:nox#org#template#replacements')
  let g:nox#org#template#replacements = {}
endif

function! g:nox#org#template#replacements.datetime(context, args) abort
  let format = get(a:args, 0, '%F %R')
  return strftime(format)
endfunction

function! g:nox#org#template#replacements.input(context, args) abort
  let prompt = get(a:args, 0, '')
  let default = get(a:args, 1, '')
  let completion = get(a:args, 2, 0)
  return s:input(prompt, default, completion)
endfunction

function! g:nox#org#template#replacements.newfile(context, args) abort
  " Accepts only one argument, so ':' is assumed to be litteral.
  let output = join(a:args, ':')
  return filereadable(a:context.path) ? '' : output
endfunction

function! g:nox#org#template#replacements.appendfile(context, args) abort
  " Accepts only one argument, so ':' is assumed to be litteral.
  let output = join(a:args, ':')
  return filereadable(a:context.path) ? output : ''
endfunction

function! g:nox#org#template#replacements.repo(context, args) abort
  let repo = get(a:args, 0, '')
  let slug = get(a:args, 1, '')
  return nox#org#repo(repo).note(slug)
endfunction

function! g:nox#org#template#replacements.ledger_amount(context, args) abort
  let prompt = get(a:args, 0, 'amount $')
  let default = get(a:args, 1, '')
  let args = [prompt, default]
  let val = g:nox#org#template#replacements.input(a:context, args)
  return printf('$%.2f', str2float(substitute(val, ',', '', 'g')))
endfunction

function! g:nox#org#template#replacements.ledger_payee(context, args) abort
  return nox#org#capture#wait('nox#fzf#ledger_choose_payee', a:args)
endfunction

function! g:nox#org#template#replacements.ledger_account(context, args) abort
  return nox#org#capture#wait('nox#fzf#ledger_choose_account', a:args)
endfunction

function! g:nox#org#template#replacements.ledger_status(context, args) abort
  let from_key = get(a:args, 0, 'xact_from_account')
  let to_key = get(a:args, 0, 'xact_to_account')
  let from_account = a:context.prop(from_key)
  let to_account = a:context.prop(to_key)
  return (from_account =~# g:LEDGER_AUTO_RECONCILE_ACCOUNTS &&
        \ (to_account !~# '^Assets:' || to_account =~# g:LEDGER_AUTO_RECONCILE_ACCOUNTS))
        \ ? ' *' : ''
endfunction

function! g:nox#org#template#replacements.inputdate(context, args) abort
  let args = copy(a:args)
  call add(args, {'callback': function('nox#org#capture#resume')})
  return nox#org#capture#wait('nox#liveinput#datepicker', args)
endfunction

function! g:nox#org#template#replacements.ledger_inputdate(context, args) abort
  let args = ['%Y/%m/%d', '%F %a', 1]
  return g:nox#org#template#replacements.inputdate(a:context, args)
endfunction

if !exists('g:nox#org#template#filters')
  let g:nox#org#template#filters = {}
endif

function! g:nox#org#template#filters._(context, args) abort
  return ''
endfunction

function! g:nox#org#template#filters.toupper(input, args) abort
  return toupper(a:input)
endfunction

function! g:nox#org#template#filters.tolower(input, args) abort
  return tolower(a:input)
endfunction

function! g:nox#org#template#filters.slugify(input, args) abort
  let input = substitute(a:input, "['!?,]", '', 'g')
  let input = substitute(input, '\W\+', '-', 'g')
  return tolower(input)
endfunction

function! g:nox#org#template#filters.titleify(input, args) abort
  return substitute(a:input, '\<[a-z]\ze[a-z0-9_-]*\>', '\u&', 'g')
endfunction

function! g:nox#org#template#filters.date(input, args) abort
  if !executable('date')
    return a:input
  endif

  let input_format = get(a:args, 0, '%F %R')
  let output_format = get(a:args, 1, '%F %R')
  let cmd = 'date -jf "'.input_format.'" "'.a:input.'" "+'.output_format.'"'
  return system(cmd)[0:-2]
endfunction

function! g:nox#org#template#filters.width(input, args) abort
  let width = get(a:args, 0, '')
  return printf('%'.width.'s', a:input)
endfunction

""
" Parse method calls into method name and arguments:
"   name:arg1::arg3\:more
"   =>
"   {'method': 'name', 'args': ['arg1', '', 'arg3:more']}
function! s:parse_placeholder_segment(segment) abort
  let args = s:split(a:segment, ':')
  let method = remove(args, 0)
  return {'method': method, 'args': args}
endfunction

""
" Evaluate placeholder strings of the form:
"   {head}
"   {head|filter1|filter2}
"   {head:arg1:arg2|filter}
"   {head|filter:arg1:arg2}
"
function! s:expand_placeholder(placeholder, context) abort
  let segments = split(a:placeholder[1:-2], '|')
  let head = s:parse_placeholder_segment(remove(segments, 0))

  if empty(head.args) && a:context.has_prop(head.method)
    silent call a:context.status.log('Doing replacement by property', head)
    let value = a:context.prop(head.method)
  elseif has_key(g:nox#org#template#replacements, head.method)
    silent call a:context.status.log('Doing replacement by method', head)
    let value = g:nox#org#template#replacements[head.method](a:context, head.args)
  else
    silent call a:context.status.log('No replacer found', head)
    return "\001"
  endif

  silent call a:context.status.log('Replacement result', value)

  for segment in segments
    let filter = s:parse_placeholder_segment(segment)
    if !has_key(g:nox#org#template#filters, filter.method)
      silent call a:context.status.log('No filter found', filter)
      return "\001"
    endif
    silent call a:context.status.log('Filtering by method', filter)
    let value = g:nox#org#template#filters[filter.method](value, filter.args)
    silent call a:context.status.log('Filter result', value)
  endfor

  return value
endfunction

function! nox#org#template#has_placeholders(template) abort
  return (a:template =~# s:placeholder_regex)
endfunction

function! nox#org#template#expand(template, context) abort
  silent call a:context.status.log('Expanding string:', a:template)

  let template = substitute(a:template, s:placeholder_regex,
        \ {match -> s:expand_placeholder(match[0], a:context)}, '')

  silent call a:context.status.log('String expansion result:', template)
  return template =~# "\001" ? '' : template
endfunction

" vim: fdm=marker:sw=2:sts=2:et
