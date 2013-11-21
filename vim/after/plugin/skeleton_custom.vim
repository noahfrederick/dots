" skeleton_custom.vim - Skeleton Custom Functions
" Maintainer:   Noah Frederick

if exists("g:loaded_skeleton_custom") || !exists("g:loaded_skeleton")
  finish
endif
let g:loaded_skeleton_custom = 1

function! SkeletonCustomReplace(filename)
  let basename = fnamemodify(a:filename, ':t:r')
  call skeleton#Replace('EMAIL', helper#snippet#Email())
  call skeleton#Replace('AUTHOR', helper#snippet#Author())
  call skeleton#Replace('GITHUB_USERNAME', helper#snippet#GitHubUsername())
  call skeleton#Replace('TITLE', helper#snippet#Title(basename))
  call skeleton#Replace('PROJECT_TITLE', helper#snippet#ProjectTitle())
endfunction

" vim: fdm=marker:sw=2:sts=2:et
