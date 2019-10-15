" autoload/my/fzf.vim - Sources and sinks for fzf
" Maintainer:   Noah Frederick
"
" Portions adapted from fzf.vim:
" https://github.com/junegunn/fzf.vim
"
" ------------------------------------------------------------------
" Common
" ------------------------------------------------------------------
function! s:strip(str)
  return substitute(a:str, '^\s*\|\s*$', '', 'g')
endfunction

function! s:escape(path)
  return escape(a:path, ' %#''"\')
endfunction

function! s:ansi(str, color, bold)
  return printf("\x1b[%s%sm%s\x1b[m", a:color, a:bold ? ';1' : '', a:str)
endfunction

for [s:c, s:a] in items({'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34, 'magenta': 35})
  execute "function! s:".s:c."(str, ...)\n"
        \ "  return s:ansi(a:str, ".s:a.", get(a:, 1, 0))\n"
        \ "endfunction"
endfor

function! s:buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val)')
endfunction

let s:default_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

function! s:fzf(opts, bang)
  return fzf#run(fzf#wrap(extend(copy(a:opts), {
        \ 'options': get(a:opts, 'options', '').s:expect(),
        \ 'sink*':   get(a:opts, 'sink*', function('s:common_sink'))}), a:bang))
endfunction

function! s:expect()
  return ' --expect='.join(keys(s:default_action), ',')
endfunction

function! s:common_sink(lines) abort
  if len(a:lines) < 2
    return
  endif
  let key = remove(a:lines, 0)
  let cmd = get(get(g:, 'fzf_action', s:default_action), key, 'e')
  if len(a:lines) > 1
    augroup fzf_swap
      autocmd SwapExists * let v:swapchoice='o'
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

function! s:warn(message)
  echohl WarningMsg
  echom a:message
  echohl None
endfunction

" ------------------------------------------------------------------
" Files
" ------------------------------------------------------------------
function! my#fzf#files(dir, bang)
  let args = {'options': '-m'}
  let dir = empty(a:dir) ? getcwd() : a:dir
  let dir = substitute(dir, '/*$', '/', '')

  if !isdirectory(expand(dir))
    call s:warn('Invalid directory')
    return
  endif

  let args.options .= ' --ansi --prompt '.shellescape(pathshorten(dir))
  let args.dir = dir

  call s:fzf(args, a:bang)
endfunction

" ------------------------------------------------------------------
" Buffers
" ------------------------------------------------------------------
function! s:bufopen(lines)
  if len(a:lines) < 2
    return
  endif

  let actions = copy(s:default_action)
  let actions['ctrl-d'] = 'bwipeout'
  let cmd = get(actions, remove(a:lines, 0), '')
  let bufs = map(copy(a:lines), 'matchstr(v:val, "\\[*\\zs[0-9]*\\ze\\]")')

  if cmd ==# 'bwipeout'
    execute cmd join(bufs)
    return
  endif

  for buf in bufs
    if !empty(cmd)
      execute 'silent' cmd
    endif
    execute 'buffer' buf
  endfor
endfunction

function! s:format_buffer(b)
  let name = bufname(a:b)
  let name = empty(name) ? '[No Name]' : name
  let flag = a:b == bufnr('') ? s:blue('%') :
        \ (a:b == bufnr('#') ? s:magenta('#') : ' ')
  let modified = getbufvar(a:b, '&modified') ? s:red(" \u25cf") : ''
  let readonly = getbufvar(a:b, '&modifiable') ? '' : s:blue(" \u25cb")
  let extra = join(filter([modified, readonly], '!empty(v:val)'), '')
  return s:strip(printf("[%s]\t%s %s\t%s", s:blue(a:b), flag, name, extra))
endfunction

function! my#fzf#buffers(bang)
  let bufs = s:buflisted()

  " Remove current and alternate buffers from list
  call filter(bufs, "v:val != bufnr('#') && v:val != bufnr('%')")

  if buflisted(0)
    call add(bufs, bufnr('#'))
  endif

  call map(bufs, 's:format_buffer(v:val)')

  call s:fzf({
        \   'source':  reverse(bufs),
        \   'sink*':   function('s:bufopen'),
        \   'options': '-m --ansi -d "\t" -n 2,1..2'.s:expect().',ctrl-d',
        \ }, a:bang)
endfunction

" ------------------------------------------------------------------
" History
" ------------------------------------------------------------------
function! s:all_files()
  return extend(
        \ filter(reverse(copy(v:oldfiles)),
        \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
        \ filter(map(s:buflisted(), 'bufname(v:val)'), '!empty(v:val)'))
endfunction

function! my#fzf#history(bang)
  call s:fzf({
        \   'source':  reverse(s:all_files()),
        \   'sink*':   function('<SID>common_sink'),
        \   'options': '-m' . s:expect(),
        \ }, a:bang)
endfunction

" ------------------------------------------------------------------
" Tags
" ------------------------------------------------------------------
function! s:tags_sink(lines)
  if len(a:lines) < 2
    return
  endif

  normal! m'

  let qfl = []
  let cmd = get(s:default_action, a:lines[0], 'edit')
  let [magic, &magic] = [&magic, 0]

  for line in a:lines[1:]
    let parts = split(line, '\t\zs')
    let excmd = matchstr(join(parts[2:], ''), '^.*\ze;"\t')
    execute cmd s:escape(parts[1][:-2])
    execute excmd
    call add(qfl, {'filename': expand('%'), 'lnum': line('.'), 'text': getline('.')})
  endfor

  let &magic = magic

  if len(qfl) > 1
    call setqflist(qfl)
    copen
    wincmd p
    clast
  endif

  normal! zz
endfunction

function! my#fzf#tags(bang)
  if empty(tagfiles())
    call inputsave()
    echohl WarningMsg
    let gen = input('tags not found. Generate? (y/N) ')
    echohl None
    call inputrestore()
    redraw
    if gen =~ '^y'
      call s:warn('Preparing tags')
      call system('ctags -R')
      if empty(tagfiles())
        return s:warn('Failed to create tags')
      endif
    else
      return s:warn('No tags found')
    endif
  endif

  let tagfile = tagfiles()[0]
  " We don't want to apply --ansi option when tags file is large as it makes
  " processing much slower.
  if getfsize(tagfile) > 1024 * 1024 * 20
    let proc = 'grep -v ''^\!'' '
    let copt = ''
  else
    let proc = 'perl -ne ''unless (/^\!/) { s/^(.*?)\t(.*?)\t/'.s:yellow('\1', 'Function').'\t'.s:blue('\2', 'String').'\t/; print }'' '
    let copt = '--ansi '
  endif

  call s:fzf({
        \ 'source':  proc.shellescape(fnamemodify(tagfile, ':t')),
        \ 'sink*':   function('s:tags_sink'),
        \ 'dir':     fnamemodify(tagfile, ':h'),
        \ 'options': copt.'-m --tiebreak=begin'}, a:bang)
endfunction

" ------------------------------------------------------------------
" Help tags
" ------------------------------------------------------------------
function! s:helptag_sink(line)
  let [tag, file, path] = split(a:line, "\t")[0:2]
  let rtp = fnamemodify(path, ':p:h:h')
  if stridx(&rtp, rtp) < 0
    execute 'set rtp+='.s:escape(rtp)
  endif
  let cmd = exists(':Help') == 2 ? 'Help' : 'help'
  execute cmd tag
endfunction

function! my#fzf#helptags(bang)
  let tags = uniq(sort(split(globpath(&runtimepath, '**/doc/tags'), '\n')))

  return s:fzf({
        \ 'source':  "grep -H '.*' ".join(map(tags, 'shellescape(v:val)')).
        \            "| perl -ne '/(.*?):(.*?)\t(.*?)\t/; printf(qq(".s:magenta('%-40s', 'Label')."\t%s\t%s\n), $2, $3, $1)' | sort",
        \ 'sink':    function('s:helptag_sink'),
        \ 'options': '--ansi +m --tiebreak=begin --with-nth ..-2'}, a:bang)
endfunction

" ------------------------------------------------------------------
" Lines
" ------------------------------------------------------------------
function! s:line_handler(lines)
  if len(a:lines) < 2
    return
  endif
  let cmd = get(s:default_action, a:lines[0], '')
  if !empty(cmd)
    execute 'silent' cmd
  endif

  let keys = split(a:lines[1], '\t')
  execute 'buffer' keys[0][1:-2]
  execute keys[1][0:-2]
  normal! ^zz
endfunction

function! s:lines()
  let cur = []
  let rest = []
  let buf = bufnr('')
  for b in s:buflisted()
    call extend(b == buf ? cur : rest,
          \ map(getbufline(b, 1, "$"),
          \ 'printf("[%s]\t%s:\t%s", s:blue(b), s:yellow(v:key + 1), v:val)'))
  endfor
  return extend(cur, rest)
endfunction

function! my#fzf#lines(bang)
  call s:fzf({
        \ 'source':  <SID>lines(),
        \ 'sink*':   function('<SID>line_handler'),
        \ 'options': '+m --tiebreak=index --ansi --reverse --nth=3..'.s:expect()
        \}, a:bang)
endfunction

" ------------------------------------------------------------------
" BLines
" ------------------------------------------------------------------
function! s:buffer_line_handler(lines)
  if len(a:lines) < 2
    return
  endif
  let cmd = get(s:default_action, a:lines[0], '')
  if !empty(cmd)
    execute 'silent' cmd
  endif

  execute split(a:lines[1], '\t')[0][0:-2]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let lines = getline(1, "$")
  if exists('b:interesting_lines_filter')
    call filter(lines, 'match(v:val, b:interesting_lines_filter) > -1')
  endif
  return map(lines,
        \ 'printf("%s:\t%s", s:yellow(v:key + 1), v:val)')
endfunction

function! my#fzf#blines(bang)
  call s:fzf({
        \ 'source':  <SID>buffer_lines(),
        \ 'sink*':   function('<SID>buffer_line_handler'),
        \ 'options': '+m --tiebreak=index --ansi --reverse --nth=2..'.s:expect()
        \}, a:bang)
endfunction

" ------------------------------------------------------------------
" Marks
" ------------------------------------------------------------------
function! s:format_mark(line)
  return substitute(a:line, '\S', '\=s:yellow(submatch(0))', '')
endfunction

function! s:mark_sink(lines)
  if len(a:lines) < 2
    return
  endif
  let cmd = get(s:default_action, a:lines[0], '')
  if !empty(cmd)
    execute 'silent' cmd
  endif
  execute 'normal! `'.matchstr(a:lines[1], '\S').'zz'
endfunction

function! my#fzf#marks(bang)
  redir => cout
  silent marks
  redir END
  let list = split(cout, "\n")
  call s:fzf({
        \ 'source':  extend(list[0:0], map(list[1:], 's:format_mark(v:val)')),
        \ 'sink*':   function('s:mark_sink'),
        \ 'options': '+m --ansi --tiebreak=index --header-lines 1 --tiebreak=begin'.s:expect()}, a:bang)
endfunction

" ------------------------------------------------------------------
" Grep
" ------------------------------------------------------------------
function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2
    return
  endif

  let cmd = get(get(g:, 'fzf_action', s:default_action), a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

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

function! my#fzf#grep(query, bang)
  call s:fzf({
        \ 'source':  printf('ag --nogroup --column --color "%s"',
        \                   escape(empty(a:query) ? '^(?=.)' : a:query, '"\-')),
        \ 'sink*':   function('s:ag_handler'),
        \ 'options': '--ansi --delimiter : --nth 4..,.. '.
        \            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
        \            '--color hl:68,hl+:110'}, a:bang)
endfunction

" ------------------------------------------------------------------
" PHP Use
" ------------------------------------------------------------------
function! s:use_sink(fqn) abort
  call composer#namespace#use(0, '\'.a:fqn)
endfunction

function! my#fzf#use(bang)
  " For now, it just offers Laravel facade classes
  let classes = sort(keys(laravel#app().facades()))

  return s:fzf({
        \ 'source': classes,
        \ 'sink':   function('s:use_sink'),
        \ 'options': '--multi'}, a:bang)
endfunction

" ------------------------------------------------------------------
" Artisan commands
" ------------------------------------------------------------------
function! s:artisan_sink(lines) abort
  if len(a:lines) < 2
    return
  endif

  let subcommand = matchstr(a:lines[1], '^\S*')
  let command = 'Artisan '.subcommand

  if empty(a:lines[0])
    call feedkeys(':'.command.' ')
  else
    execute command
  endif
endfunction

function! s:artisan_commands() abort
  let lines = []
  for [name, description] in items(laravel#app().artisan_commands())
    call add(lines, s:format_artisan_line(name, description))
  endfor
  return sort(lines)
endfunction

function! s:format_artisan_line(name, description) abort
  return printf("%s\t%s", s:green(a:name), a:description)
endfunction

function! my#fzf#artisan(bang) abort
  return s:fzf({
        \ 'source':  s:artisan_commands(),
        \ 'sink':    function('s:artisan_sink'),
        \ 'options': '--ansi --expect ctrl-x +m'.
        \            ' --tabstop=20 --nth=1 --delimiter="\t"'}, a:bang)
endfunction

" ------------------------------------------------------------------
" Ledger
" ------------------------------------------------------------------
function! s:ledger_accounts(...) abort
  let filter = get(a:000, 0, '')
  return systemlist('ledger accounts --permissive ' . filter)
endfunction

function! my#fzf#ledger_accounts(filter, opts, bang) abort
  call s:fzf(extend({
        \   'source': s:ledger_accounts(a:filter),
        \ }, a:opts), a:bang)
endfunction

function! s:ledger_payees() abort
  return systemlist('ledger payees --permissive')
endfunction

function! my#fzf#ledger_payees(opts, bang) abort
  call s:fzf(extend({
        \   'source': s:ledger_payees(),
        \ }, a:opts), a:bang)
endfunction

function! my#fzf#ledger_choose_account(...) abort
  let prompt = get(a:000, 0, 'account')
  let filter = get(a:000, 1, '')
  call my#fzf#ledger_accounts(filter, {
        \ 'sink*': function('my#fzf#ledger_choose_account_callback'),
        \ 'options': '--expect=tab,ctrl-y --print-query --prompt='.shellescape(prompt.' > '),
        \ }, 0)
  " Hack to gaurantee entering of terminal mode when :startinsert fails.
  call feedkeys("\<C-\>\<C-n>i")
endfunction

function! my#fzf#ledger_choose_account_callback(lines) abort
  if len(a:lines) < 2
    return
  endif

  if empty(a:lines[1])
    let account = get(a:lines, 2, a:lines[0])
  else
    let account = a:lines[0]
  endif

  return my#org#capture#resume(account)
endfunction

function! my#fzf#ledger_choose_payee(...) abort
  let prompt = get(a:000, 0, 'payee')
  call my#fzf#ledger_payees({
        \ 'sink*': function('my#fzf#ledger_choose_payee_callback'),
        \ 'options': '--expect=tab,ctrl-y --print-query --prompt='.shellescape(prompt.' > '),
        \ }, 0)
  " Hack to gaurantee entering of terminal mode when :startinsert fails.
  call feedkeys("\<C-\>\<C-n>i")
endfunction

function! my#fzf#ledger_choose_payee_callback(lines) abort
  if len(a:lines) < 2
    return
  endif

  if empty(a:lines[1])
    let payee = get(a:lines, 2, a:lines[0])
  else
    let payee = a:lines[0]
  endif

  return my#org#capture#resume(payee)
endfunction

" vim:set et sw=2:
