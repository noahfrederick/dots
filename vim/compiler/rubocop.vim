" Vim compiler file
" Compiler:     RuboCop
" Language:     Ruby

let current_compiler = 'rubocop'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

CompilerSet makeprg=rubocop\ --format\ emacs\ $*\ %:S

CompilerSet errorformat=
      \%W%f:%l:%c:\ C:\ %m,
      \%W%f:%l:%c:\ W:\ %m,
      \%E%f:%l:%c:\ E:\ %m,
      \%E%f:%l:%c:\ F:\ %m

let &cpoptions = s:cpo_save
unlet s:cpo_save

" vim: fdm=marker:sw=2:sts=2:et
