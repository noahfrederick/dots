" autoload/nox/org/fzf.vim - Organizer and note-taking system
" Maintainer:   Noah Frederick

let s:has_rougify = executable('rougify')
let s:has_fish = ($SHELL =~# 'fish$')

function! s:strip(str) abort
  return substitute(a:str, '^\s*\|\s*$', '', 'g')
endfunction

function! s:escape(path) abort
  return escape(a:path, ' %#''"\')
endfunction

function! s:ansi(str, color, bold) abort
  return printf("\x1b[%s%sm%s\x1b[m", a:color, a:bold ? ';1' : '', a:str)
endfunction

for [s:c, s:a] in items({'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34, 'magenta': 35})
  execute "function! s:".s:c."(str, ...)\n"
        \ "  return s:ansi(a:str, ".s:a.", get(a:, 1, 0))\n"
        \ "endfunction"
endfor

function! s:fzf(opts, fullscreen) abort
  return fzf#run(extend(a:opts, a:fullscreen ? {} : {'up': '~30%'}))
endfunction

let s:actions = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

function! s:wrap(opts) abort
  return extend(copy(a:opts), {
        \ 'options': get(a:opts, 'options', '').s:expect(),
        \ 'sink*':   get(a:opts, 'sink*', function('s:common_sink'))})
endfunction

function! s:expect() abort
  return ' --expect='.join(keys(s:actions), ',')
endfunction

function! s:common_sink(lines) abort
  if len(a:lines) < 2
    return
  endif
  let key = remove(a:lines, 0)
  let cmd = get(s:actions, key, 'edit')
  if len(a:lines) > 1
    augroup fzf_swap
      autocmd SwapExists * let v:swapchoice = 'o'
            \| call s:warn('fzf: E325: swap file exists: '.expand('<afile>'))
    augroup END
  endif
  try
    let autochdir = &autochdir
    set noautochdir
    for item in a:lines
      execute cmd s:escape(item)
      if exists('#BufEnter') && isdirectory(item)
        doautocmd BufEnter
      endif
    endfor
  finally
    let &autochdir = autochdir
    silent! autocmd! fzf_swap
  endtry
endfunction

function! s:warn(message) abort
  echohl WarningMsg
  echom a:message
  echohl None
endfunction

" ------------------------------------------------------------------
" Capture Templates
" ------------------------------------------------------------------
function! s:templates() abort
  let lines = []
  for [name, body] in items(g:nox#org#capture#templates)
    call add(lines, printf("%s\t%s", s:magenta(name), body.description))
  endfor
  return sort(lines)
endfunction

function! s:capture_handler(lines) abort
  let bang = g:nox#org#fzf#bang
  unlet! g:nox#org#fzf#bang

  if len(a:lines) < 2
    return
  endif

  let template = split(a:lines[1], "\t")[0]
  execute 'Capture'.bang template
endfunction

function! nox#org#fzf#capture(bang) abort
  let templates = s:templates()

  if empty(templates)
    return
  endif

  let g:nox#org#fzf#bang = a:bang

  let args = {'options': '--reverse --ansi --tabstop=18'}
  let args.options .= ' --prompt='.shellescape('capture > ')
  let args.source = templates
  let args['sink*'] = function('<SID>capture_handler')

  call s:fzf(s:wrap(args), 0)
endfunction

" ------------------------------------------------------------------
" Files
" ------------------------------------------------------------------
function! s:notes(repo) abort
  if empty(a:repo)
    return nox#org#notes()
  endif

  let repo = nox#org#repo(a:repo)

  if empty(repo)
    return
  endif

  return repo.notes()
endfunction

function! s:note_handler(lines) abort
  if len(a:lines) < 2
    return
  endif

  let lines = a:lines
  let lines[1] = nox#org#resolve(lines[1])

  return s:common_sink(lines)
endfunction

function! s:note_preview() abort
  let bin = s:has_rougify ? 'rougify highlight --lexer markdown --theme monokai' : 'cat'
  let path = 'echo '.shellescape(':{1}.md').' | sed'

  for name in reverse(sort(nox#org#repos()))
    let repo = nox#org#repo(name)
    let path .= ' -e '.shellescape('s!^:'.repo.prefix().'!'.repo.path().'/!')
  endfor

  if s:has_fish
    let format = ' --preview="if test -r (%s); %s (%s); end"'
  else
    let format = ' --preview="if test -r $(%s); then; %s $(%s); fi"'
  endif

  return printf(format, path, bin, path)
endfunction

function! nox#org#fzf#notes(repo, fullscreen) abort
  let notes = s:notes(a:repo)

  if empty(notes)
    return
  endif

  let prompt = empty(a:repo) ? 'notes' : 'notes/'.a:repo
  let args = {'options': '--multi --reverse'}
  let args.options .= ' --prompt='.shellescape(prompt.' > ')
  let args.options .= s:note_preview()
  let args.source = notes
  let args['sink*'] = function('<SID>note_handler')

  call s:fzf(s:wrap(args), a:fullscreen)
endfunction

" ------------------------------------------------------------------
" Grep
" ------------------------------------------------------------------
function! s:ag_to_qf(line) abort
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines) abort
  if len(a:lines) < 2
    return
  endif

  let cmd = get(s:actions, a:lines[0], 'edit')
  let list = map(a:lines[1:], {idx, val -> s:ag_to_qf(val)})

  let first = list[0]
  execute cmd s:escape(first.filename)
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

function! nox#org#fzf#grep(query, fullscreen) abort
  call s:fzf(s:wrap({
        \ 'source':  printf('ag --nogroup --column --color "%s" %s',
        \                   escape(empty(a:query) ? '^(?=.)' : a:query, '"\-'),
        \                   shellescape(nox#org#repo().path())),
        \ 'sink*':   function('s:ag_handler'),
        \ 'options': '--ansi --delimiter : --nth 4..,.. '.
        \            '--multi --reverse --tiebreak=index '.
        \            '--color hl:68,hl+:110'}), a:fullscreen)
endfunction

" ------------------------------------------------------------------
" Non-interactive filter
" ------------------------------------------------------------------
function! nox#org#fzf#guess(query, items)
  let args = [
        \ 'echo',
        \ '"'.escape(join(a:items, "\n"), '"').'"',
        \ '|',
        \ 'fzf --filter',
        \ shellescape(a:query),
        \ ]
  let result = system(join(args))
  return split(result, "\n")[0]
endfunction

" vim: fdm=marker:sw=2:sts=2:et
