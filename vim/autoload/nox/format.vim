" autoload/nox/format.vim - Formatting helpers

function! nox#format#JsBeautify() range abort
  if !executable('js-beautify')
    throw "js-beautify is not available"
  endif

  if &filetype =~# '^javascript' || &filetype =~# '^json'
    let ft = 'js'
  elseif &filetype =~# '\.'
    let parts = split(&filetype, '\.')
    let ft = parts[0]
  else
    let ft = &filetype
  endif

  let cmd = [
        \ '!js-beautify',
        \ '--file -',
        \ '--type',
        \ ft,
        \ ]

  if (ft ==# 'js' || ft ==# 'html') && &textwidth > 0
    let cmd = add(cmd, '--wrap-line-length ' . &textwidth)
  endif

  if ft ==# 'html'
    let cmd = add(cmd, '--indent-inner-html')
  endif

  if &expandtab
    let cmd = add(cmd, '--indent-size ' . &shiftwidth)
  else
    let cmd = add(cmd, '--indent-with-tabs')
  endif

  execute a:firstline . ',' . a:lastline . join(cmd)
endfunction

" vim: fdm=marker:sw=2:sts=2:et
