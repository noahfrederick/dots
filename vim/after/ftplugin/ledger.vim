" after/ftplugin/ledger.vim - Ledger helpers
" Maintainer: Noah Frederick

let s:account_width = 36

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
    let account2 = g:LEDGER_DEFAULT_SPLIT_ACCOUNT
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
    let account2 = g:LEDGER_DEFAULT_SPLIT_ACCOUNT
  endif

  let amount = input('Amount ($): ')

  if amount == ''
    let amount = '0.00'
  elseif amount =~ '^\d\+$'
    let amount = amount . '.00'
  endif

  call ledger#split(account2, amount)
endfunction

nnoremap <silent> <Plug>(LedgerSplit) :call ledger#split()<CR>:silent! call repeat#set("\<Plug>(LedgerSplit)")<CR>
nnoremap <silent> <Plug>(LedgerSplitPrompt) :call ledger#split_prompt()<CR>

nmap <buffer> <LocalLeader>s <Plug>(LedgerSplit)
nmap <buffer> <LocalLeader>S <Plug>(LedgerSplitPrompt)

cnoremap <buffer> <C-g><C-t> <C-r>=strftime('%Y/%m/%d')<CR>

command! -buffer -nargs=* Entry read !ledger entry <args> 2>/dev/null

let b:interesting_lines_filter = '\v^\d{4}'

" vim: fdm=marker:sw=2:sts=2:et
