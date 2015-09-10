" autoload/nox/format.vim - Formatting helpers

function! nox#format#JsBeautify() range abort
  if !executable('js-beautify')
    throw "js-beautify is not available"
  endif

  let ft = &filetype =~# '\.' ? split(&filetype, '\.')[0] : &filetype

  if ft ==# 'javascript' || ft ==# 'json'
    let ft = 'js'
  elseif ft =~# '^\(smarty\|mustache\)$'
    let ft = 'html'
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

function! nox#format#PhpFmt() abort
  if !executable('php')
    throw "php is not available"
  elseif glob('~/.composer/vendor/bin/fmt.php') ==# ''
    throw "fmt.php is not available"
  endif

  let cmd = [
        \ 'php',
        \ '~/.composer/vendor/bin/fmt.php',
        \ '--psr2',
        \ '--no-backup',
        \ expand('%:p')
        \ ]

  try
    let b:old_syntastic_mode = get(b:, 'syntastic_mode', -1)
    let b:syntastic_mode = 0

    " The script formats the file in place, so we need to do a dance to make it
    " work like other format commands:
    update
    let result = system(join(cmd))
    if v:shell_error != 0
      throw result
    else
      silent edit
      silent undo
      silent update
      silent redo
    endif
  finally
    if b:old_syntastic_mode == -1
      unlet b:syntastic_mode
    else
      let b:syntastic_mode = b:old_syntastic_mode
    endif
    unlet b:old_syntastic_mode
  endtry
endfunction

" vim: fdm=marker:sw=2:sts=2:et
