" autoload/nox/fzf.vim - Sources and sinks for fzf
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

function! s:fzf(opts, bang)
  return fzf#run(extend(a:opts, a:bang ? {} : {'down': 20}))
endfunction

let s:default_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

function! s:expect()
  return ' --expect='.join(keys(s:default_action), ',')
endfunction

" ------------------------------------------------------------------
" Buffers
" ------------------------------------------------------------------
function! s:bufopen(lines)
  if len(a:lines) < 2
    return
  endif
  let cmd = get(s:default_action, a:lines[0], '')
  if !empty(cmd)
    execute 'silent' cmd
  endif
  execute 'buffer' matchstr(a:lines[1], '\s*\zs[0-9]*\ze\s')
endfunction

function! s:format_buffer(b)
  let name = bufname(a:b)
  let name = empty(name) ? '[No Name]' : name
  let flag = a:b == bufnr('')  ? s:blue('%') :
        \ (a:b == bufnr('#') ? s:magenta('#') : ' ')
  let modified = getbufvar(a:b, '&modified') ? s:red(" \u25cf") : ''
  let readonly = getbufvar(a:b, '&modifiable') ? '' : s:blue(" \u25cb")
  let extra = join(filter([modified, readonly], '!empty(v:val)'), '')
  return s:strip(printf("%s %s\t%s\t%s", s:black(a:b, 1), flag, name, extra))
endfunction

function! nox#fzf#Buffers(bang)
  let bufs = s:buflisted()

  " Remove current and alternate buffers from list
  call filter(bufs, "v:val != bufnr('#') && v:val != bufnr('%')")

  if bufnr('#') > 0
    call add(bufs, bufnr('#'))
  endif

  let height = min([len(bufs), &lines * 4 / 10]) + 1

  call map(bufs, 's:format_buffer(v:val)')

  call fzf#run(extend({
        \ 'source':  reverse(bufs),
        \ 'sink*':   function('s:bufopen'),
        \ 'options': '+m --reverse --ansi -d "\t" -n 2,1..2'.s:expect(),
        \}, a:bang ? {} : {'up': height}))
endfunction

" ------------------------------------------------------------------
" Tags
" ------------------------------------------------------------------
function! s:tags_sink(lines)
  if len(a:lines) < 2
    return
  endif

  let cmd = get(s:default_action, a:lines[0], 'edit')
  let parts = split(a:lines[1], '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent' cmd s:escape(parts[1][:-2])
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! nox#fzf#Tags(bang)
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R --languages=-javascript,sql')
  endif

  call s:fzf({
        \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
        \            '| grep -v "^!"',
        \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --prompt "Tags > "'.s:expect(),
        \ 'sink*':   function('s:tags_sink')}, a:bang)
endfunction

" ------------------------------------------------------------------
" Buffer Lines
" ------------------------------------------------------------------
function! nox#fzf#BufferLines()
  let lines = map(getline(0, '$'), '(v:key + 1) . ":\t" . v:val')

  if exists('b:interesting_lines_filter')
    call filter(lines, 'strpart(v:val, stridx(v:val, "\t") + 1) =~# b:interesting_lines_filter')
  endif

  return lines
endfunction

function! nox#fzf#JumpToLine(l)
  let keys = split(a:l, ':\t')
  execute keys[0]
  normal! zOzz
endfunction

" vim:set et sw=2:
