" autoload/notes/replacements.vim - Custom capture template replacements
" Maintainer: Noah Frederick

function! g:notes#template#replacements.ledger_amount(context, args) abort
  let prompt = get(a:args, 0, 'amount $')
  let default = get(a:args, 1, '')
  let args = [prompt, default]
  let val = g:notes#template#replacements.input(a:context, args)
  return printf('$%.2f', str2float(substitute(val, ',', '', 'g')))
endfunction

function! g:notes#template#replacements.ledger_payee(context, args) abort
  return notes#capture#wait('my#fzf#ledger_choose_payee', a:args)
endfunction

function! g:notes#template#replacements.ledger_account(context, args) abort
  return notes#capture#wait('my#fzf#ledger_choose_account', a:args)
endfunction

function! g:notes#template#replacements.ledger_status(context, args) abort
  let from_key = get(a:args, 0, 'xact_from_account')
  let to_key = get(a:args, 0, 'xact_to_account')
  let from_account = a:context.prop(from_key)
  let to_account = a:context.prop(to_key)
  return (from_account =~# $LEDGER_AUTO_RECONCILE_ACCOUNTS &&
        \ (to_account !~# '^Assets:' || to_account =~# $LEDGER_AUTO_RECONCILE_ACCOUNTS))
        \ ? ' *' : ''
endfunction

function! g:notes#template#replacements.ledger_date(context, args) abort
  let args = ['%Y/%m/%d']
  return g:notes#template#replacements.datetime(a:context, args)
endfunction

function! g:notes#template#replacements.inputdate(context, args) abort
  let args = copy(a:args)
  call add(args, {'callback': function('notes#capture#resume')})
  return notes#capture#wait('my#liveinput#datepicker', args)
endfunction

function! g:notes#template#replacements.ledger_inputdate(context, args) abort
  let args = ['%Y/%m/%d', '%F %a', 1]
  return g:notes#template#replacements.inputdate(a:context, args)
endfunction

" vim: fdm=marker:sw=2:sts=2:et
