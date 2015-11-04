" compiler/phpmd.vim - Checker for phpmd
" Maintainer: Noah Frederick

let current_compiler = 'phpmd'

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=phpmd\ \"%\"\ text\ codesize,design,unusedcode,naming
CompilerSet errorformat=%E%f:%l%\\s%#%m

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: fdm=marker:sw=2:sts=2:et
