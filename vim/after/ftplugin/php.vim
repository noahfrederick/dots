" after/ftplugin/php.vim - Settings for PHP

set suffixesadd+=.php

" Use :make to check PHP syntax
setlocal makeprg=php\ -l\ % errorformat=%m\ in\ %f\ on\ line\ %l

" Settings for bundled PHP plug-in
let g:php_noShortTags = 1         " Always use <?php

" Folding options
setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal foldlevel=1
setlocal foldnestmax=2
" These are window-local, so they have to be unset on tear-down

" Copied here from indent/php.vim since the setting gets overridden by
" ftplugin/html.vim when 'filetype' is reset:
setlocal comments=s1:/*,mb:*,ex:*/,://,:#

if exists(':Switch')
  let b:switch_custom_definitions = [
        \   {
        \     '\[\(\$\k\+\)\]': '->\1',
        \     '\->\(\$\k\+\)': '[\1]',
        \   },
        \   {
        \     '\[[''"]\(\k\+\)[''"]\]': '->\1',
        \     '\->\(\k\+\)': '[''\1'']',
        \   },
        \   {
        \     '\[.\{-}\]': {
        \       '\[': 'array(',
        \       '.\{-}': '\1',
        \       ']': ')',
        \     },
        \   },
        \   {
        \     'array(.\{-})': {
        \       'array(': '[',
        \       '.\{-}': '\1',
        \       ')': ']',
        \     },
        \   },
        \ ]
endif

" Function text objects via
" https://github.com/kana/vim-textobj-function
let b:textobj_function_select = function('php#FunctionSelect')

call nox#filetype#MakeSemicolonMaps()
call nox#filetype#MakeRocketMaps()

command! -buffer -bar -nargs=0 Format call nox#format#PhpFmt()

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | setlocal foldmethod< foldmarker< foldlevel< foldnestmax<
      \ | unlet! b:textobj_function_select b:switch_custom_definitions
      \ '

" vim: fdm=marker:sw=2:sts=2:et
