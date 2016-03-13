" compiler/php.vim - Checker for php
" Maintainer: Noah Frederick

let current_compiler = 'php'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=php
      \\ -d\ error_reporting=E_ALL
      \\ -d\ display_errors=1
      \\ -d\ log_errors=0
      \\ -d\ xdebug.cli_color=0
      \\ -l\ %:S
CompilerSet errorformat=
      \%-GNo\ syntax\ errors\ detected\ in%.%#,
      \Parse\ error:\ %#syntax\ %trror\,\ %m\ in\ %f\ on\ line\ %l,
      \Parse\ %trror:\ %m\ in\ %f\ on\ line\ %l,
      \Fatal\ %trror:\ %m\ in\ %f\ on\ line\ %l,
      \%-G\s%#,
      \%-GErrors\ parsing\ %.%#

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: fdm=marker:sw=2:sts=2:et
