" autoload/nox/liveinput.vim - Show the result of your input as you type
" Maintainer: Noah Frederick

function! nox#liveinput#input(opts) abort
  let defaults = {
        \ 'prompt': ' → ',
        \ 'text': '',
        \ 'filetype': '',
        \ 'filter': {input -> input},
        \ 'callback': function('s:echomsg'),
        \ }
  let opts = extend(deepcopy(a:opts), defaults, 'keep')
  let opts.filter_post = get(opts, 'filter_post', opts.filter)

  return s:buffer_setup(opts)
endfunction

function! nox#liveinput#datepicker(...) abort
  let args = copy(a:000)
  if len(args) > 0 && type(get(args, -1, 0)) == type({})
    let opts = remove(args, -1)
  else
    let opts = {}
  endif
  let format = get(args, 0, '%F %a')
  let preview_format = get(args, 1, format)
  let past_context = get(args, 2, 0)
  let opts.prompt = strftime(preview_format).' → '

  let opts.filter_post = [function('s:date_filter'), format, past_context]
  let opts.filter = [function('s:date_filter'), preview_format, past_context]

  return nox#liveinput#input(opts)
endfunction

let s:prev_window = 0

sign define liveinput text=> texthl=LiveInputCaret
highlight default link LiveInputCaret Question
highlight default link LiveInputOutput IncSearch

function! s:echomsg(msg) abort
  echomsg 'liveinput: '.a:msg
endfunction

function! s:buffer_setup(opts) abort
  let filetype = 'liveinput'
  if !empty(a:opts.filetype)
    let filetype .= '.'.a:opts.filetype
  endif

  let s:prev_window = winnr()

  silent vsplit [liveinput]
  wincmd J
  resize 1
  setlocal buftype=nofile bufhidden=wipe
  setlocal nonumber nocursorline nocursorcolumn
  setlocal foldcolumn=1
  setlocal statusline=\ %{b:opts.prompt}%#LiveInputOutput#%{b:output}%*
  let b:deoplete_disable_auto_complete = 1
  let b:lexima_disabled = 1
  if exists('g:lexima_map_escape')
    let s:lexima_map_escape = g:lexima_map_escape
    let g:lexima_map_escape = ''
  endif
  let b:opts = a:opts
  let b:output = ''
  let &filetype = filetype

  if !empty(a:opts.text)
    put =a:opts.text
    global/^$/delete_
  endif

  execute 'sign place 1 line=1 name=liveinput buffer='.bufnr('%')

  call s:buffer_maps()
  autocmd TextChanged,TextChangedI <buffer> call s:textchanged()
  call s:textchanged()
  call feedkeys('A')
endfunction

function! s:buffer_maps() abort
  inoremap <silent><buffer> <Plug>(liveinput-submit) <Esc>:<C-u>call <SID>submit()<CR>
  inoremap <silent><buffer> <Plug>(liveinput-cancel) <Esc>:<C-u>call <SID>cancel()<CR>
  inoremap <silent><buffer> <Plug>(liveinput-debug)  <Esc>:<C-u>call <SID>debug()<CR>
  nnoremap <silent><buffer> <Plug>(liveinput-submit) :<C-u>call <SID>submit()<CR>
  nnoremap <silent><buffer> <Plug>(liveinput-cancel) :<C-u>call <SID>cancel()<CR>
  nnoremap <silent><buffer> <Plug>(liveinput-debug)  :<C-u>call <SID>debug()<CR>
  imap <buffer> <CR>  <Plug>(liveinput-submit)
  imap <buffer><nowait> <Esc> <Plug>(liveinput-cancel)
  imap <buffer> <C-c> <Plug>(liveinput-cancel)
  imap <buffer> <C-d> <Plug>(liveinput-debug)
  nmap <buffer> <CR>  <Plug>(liveinput-submit)
  nmap <buffer> <Esc> <Plug>(liveinput-cancel)
  nmap <buffer> <C-c> <Plug>(liveinput-cancel)
  nmap <buffer> <C-d> <Plug>(liveinput-debug)
endfunction

function! s:debug() abort
  PP b:opts
  PP b:output
endfunction

function! s:input() abort
  return getline('.')
endfunction

function! s:call(filter, input) abort
  let args = type(a:filter) == type([]) ? copy(a:filter) : [a:filter]
  let Filter = remove(args, 0)
  let args = [a:input] + args
  return call(Filter, args)
endfunction

function! s:textchanged() abort
  try
    let b:output = s:call(b:opts.filter, s:input())
  catch
    let b:output = 'Exception: '.v:exception
  endtry
endfunction

function! s:submit() abort
  let Callback = b:opts.callback
  try
    let output = s:call(b:opts.filter_post, s:input())
  catch
    call s:echomsg(v:exception)
  finally
    silent call s:buffer_teardown()
  endtry
  return call(Callback, [output])
endfunction

function! s:cancel() abort
  echomsg 'Canceled'
  silent call s:buffer_teardown()
endfunction

function! s:buffer_teardown() abort
  quit!
  if exists('g:lexima_map_escape')
    let g:lexima_map_escape = s:lexima_map_escape
    unlet s:lexima_map_escape
  endif
  if s:prev_window
    execute s:prev_window.'wincmd w'
  endif
endfunction

function! s:date_filter(input, format, past_context) abort
  let args = ['datepicker']
  if a:past_context
    call add(args, '--past')
  endif
  call add(args, '--format')
  call add(args, shellescape(a:format))
  call add(args, '--')
  call add(args, shellescape(a:input))
  let output = system(join(args))
  return substitute(output, "\n", '', 'g')
endfunction

" vim: fdm=marker:sw=2:sts=2:et
