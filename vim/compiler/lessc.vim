" compiler/lessc.vim - Checker for lessc
" Maintainer: Noah Frederick

let current_compiler = 'lessc'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=lessc\ --no-color\ %:S
CompilerSet errorformat=
      \%m\ in\ %f\ on\ line\ %l\\,\ column\ %c:,
      \%m\ in\ %f:%l:%c,
      \%-G%.%#

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: fdm=marker:sw=2:sts=2:et
