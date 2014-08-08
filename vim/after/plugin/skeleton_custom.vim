" skeleton_custom.vim - Skeleton Custom Functions
" Maintainer:   Noah Frederick

if exists("g:loaded_skeleton_custom") || !exists(":SkelEdit")
  finish
endif
let g:loaded_skeleton_custom = 1

function! g:skeleton_replacements.EMAIL()
  return helper#snippet#Email()
endfunction

function! g:skeleton_replacements.AUTHOR()
  return helper#snippet#Author()
endfunction

function! g:skeleton_replacements.GITHUB_USERNAME()
  return helper#snippet#GitHubUsername()
endfunction

function! g:skeleton_replacements.TITLE()
  let basename = expand('%:t:r')
  return helper#snippet#Title(basename)
endfunction

function! g:skeleton_replacements.PROJECT_TITLE()
  return helper#snippet#ProjectTitle()
endfunction

" vim: fdm=marker:sw=2:sts=2:et
