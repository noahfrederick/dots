" compiler/phpcs.vim - Checker for phpcs
" Maintainer: Noah Frederick

let current_compiler = 'phpcs'

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=phpcs\ \"%\"\ --report=csv

if exists("b:compiler_phpcs_standard")
  let &l:makeprg = &l:makeprg . " --standard=" . b:compiler_phpcs_standard
endif

if exists("b:compiler_phpcs_tab_width")
  let &l:makeprg = &l:makeprg . " --tab-width=" . b:compiler_phpcs_tab_width
endif

CompilerSet errorformat=
      \%-GFile\\,Line\\,Column\\,Type\\,Message\\,Source\\,Severity%.%#,
      \\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"\\,%*[a-zA-Z0-9_.-]\\,%*[0-9]%.%#

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: fdm=marker:sw=2:sts=2:et
