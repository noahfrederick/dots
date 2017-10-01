" autoload/my/puppet.vim - Puppet file-type helpers

""
" Infer the class name from file's path.
"
" Example:
"   modules/manifests/foo/bar.pp -> foo::bar
function! my#puppet#path_to_class_name(...)
  if a:0
    let path = a:1
  else
    let path = expand('%:p')
  endif

  let suffix = my#path#remove_prefix('/modules/', path)

  if suffix ==# path
    let suffix = fnamemodify(suffix, ':t')
  endif

  let suffix = substitute(suffix, '/manifests/', '/', '')

  return substitute(fnamemodify(suffix, ':r'), '/', '::', 'g')
endfunction

" vim: fdm=marker:sw=2:sts=2:et
