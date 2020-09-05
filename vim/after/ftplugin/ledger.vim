" after/ftplugin/ledger.vim - Ledger helpers
" Maintainer: Noah Frederick

let s:account_width = 36
let g:ledger_align_at = 50

function! s:format_posting(account, value)
  let account = a:account . repeat(' ', s:account_width - strlen(a:account))
  let value = '$' . a:value
  return printf('    %s  %10s', account, value)
endfunction

function! s:dollar_operate(operator, a, b)
  let result = systemlist(printf('echo "scale = 2; %s %s %s" | bc', a:a, a:operator, a:b))
  return result[0]
endfunction

""
" Split the posting on the current line between the listed account and
" [account2] with [amount2] being alloted to the second account.
function! ledger#split(...) abort
  let total = matchstr(getline('.'), '[+-]\?\d\+\.\d\+$')

  if a:0 >= 2
    let amount2 = a:2
  else
    let amount2 = s:dollar_operate('/', total, 2)
  endif

  if a:0 >= 1
    let account2 = a:1
  else
    let account2 = $LEDGER_DEFAULT_SPLIT_ACCOUNT
  endif

  let account1 = matchstr(getline('.'), '    \zs.\+  ')
  let account1 = substitute(account1, '\s*$', '', '')
  let amount1 = s:dollar_operate('-', total, amount2)

  let posting1 = s:format_posting(account1, amount1)
  let posting2 = s:format_posting(account2, amount2)

  delete _
  -1put =posting2
  -1put =posting1
endfunction

function! ledger#split_prompt(...) abort
  if a:0 >= 1
    let account2 = a:1
  else
    let account2 = $LEDGER_DEFAULT_SPLIT_ACCOUNT
  endif

  let amount = input('Amount ($): ')

  if amount == ''
    let amount = '0.00'
  elseif amount =~ '^\d\+$'
    let amount = amount . '.00'
  endif

  call ledger#split(account2, amount)
endfunction

function! ledger#insert_entry() abort
  call my#org#capture#it({
        \   'path': '%',
        \   'append': '.',
        \   'xact_account': '{ledger_account}',
        \   'xact_amount': '{ledger_amount}',
        \   'template': [
        \     '    {xact_account|width:-36}  {xact_amount|width:10}',
        \   ],
        \ })
endfunction

nnoremap <silent> <Plug>(ledger-split) :call ledger#split()<CR>:silent! call repeat#set("\<Plug>(ledger-split)")<CR>
nnoremap <silent> <Plug>(ledger-split-prompt) :call ledger#split_prompt()<CR>
nnoremap <silent> <Plug>(ledger-cycle-state) :call ledger#transaction_state_toggle(line('.'), ' *?!')<CR>
nnoremap <silent> <Plug>(ledger-toggle-state) :call ledger#transaction_state_toggle(line('.'), ' *')<CR>:silent! call repeat#set("\<Plug>(ledger-toggle-state)")<CR>
nnoremap <silent> <Plug>(ledger-align) :LedgerAlign<CR>
inoremap <silent> <Plug>(ledger-align-amount) <C-r>=ledger#align_amount_at_cursor()<CR>
nnoremap <silent> <Plug>(ledger-entry) :call ledger#entry()<CR>
nnoremap <silent> <Plug>(ledger-insert-entry) :call ledger#insert_entry()<CR>
inoremap <silent> <Plug>(ledger-insert-entry) <Esc>:call ledger#insert_entry()<CR>
nmap <silent> <Plug>(ledger-reconcile-put) <Plug>(ledger-toggle-state)<C-w>wdap<C-w>w
nmap <silent> <Plug>(ledger-reconcile-get) <C-w>wdap<C-w>wp<Plug>(ledger-toggle-state)
nnoremap <silent> <Plug>(ledger-reconcile-discard) <C-w>wdap<C-w>w
nnoremap <silent> <Plug>(ledger-fixme) :put='    ;:fixme:'<CR>

nmap <buffer> <LocalLeader>s <Plug>(ledger-split)
nmap <buffer> <LocalLeader>S <Plug>(ledger-split-prompt)
nmap <buffer> <LocalLeader><LocalLeader> <Plug>(ledger-cycle-state)
nmap <buffer> <CR>           <Plug>(ledger-toggle-state)
nnoremap <buffer> <LocalLeader>a :'{,'}LedgerAlign<CR>
xmap <buffer> <LocalLeader>a <Plug>(ledger-align)
imap <buffer> <C-l>          <Plug>(ledger-align-amount)
nmap <buffer> <LocalLeader>e <Plug>(ledger-entry)
nnoremap <buffer> <LocalLeader>= gg:/\d\{4}/,$Sort<CR>
nmap <buffer> <Leader>=      <LocalLeader>=
nmap <buffer> <LocalLeader>_ <Plug>(ledger-insert-entry)
nmap <buffer> <LocalLeader>. <Plug>(ledger-insert-entry)
nmap <buffer> <LocalLeader>] <Plug>(ledger-reconcile-put)
nmap <buffer> <LocalLeader>[ <Plug>(ledger-reconcile-get)
nmap <buffer> <LocalLeader><BS> <Plug>(ledger-reconcile-discard)
nmap <buffer> <LocalLeader>f <Plug>(ledger-fixme)

cnoremap <buffer> <C-g><C-t> <C-r>=strftime('%Y/%m/%d')<CR>
inoremap <buffer> <C-g><C-t> <C-r>=strftime('%Y/%m/%d')<CR>

" Traversing folds
nnoremap <C-k> zMzkzv[zzz
nnoremap <C-j> zMzjzvzz

command! -buffer -nargs=* Entry put ='' | execute 'read !ledger entry' escape(<q-args>, '$~*%') '2>/dev/null'
command! -buffer -nargs=0 -range=% -bar Sort <line1>,<line2>!ledger -f - print --sort d

let b:interesting_lines_filter = '\v^\d{4}'
let b:accio = ['ledger']

" vim: fdm=marker:sw=2:sts=2:et
