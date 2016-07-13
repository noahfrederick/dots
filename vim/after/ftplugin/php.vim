" after/ftplugin/php.vim - Settings for PHP

set suffixesadd+=.php

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
let b:textobj_function_select = function('php#function_select')
let b:accio = ['php', 'phpcs', 'phpmd']

call nox#filetype#make_semicolon_maps()
call nox#filetype#make_sparkup_maps()

command! -buffer -bar -nargs=0 Format call nox#format#php_fmt()

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '
      \ | setlocal foldmethod< foldmarker< foldlevel< foldnestmax<
      \ | unlet! b:textobj_function_select b:switch_custom_definitions
      \ | unlet! b:accio
      \ '

" vim: fdm=marker:sw=2:sts=2:et
