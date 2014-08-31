" autoload/puppet.vim - Puppet file-type helpers

""
" Infer the class name from file's path.
"
" Example:
"   modules/manifests/foo/bar.pp -> foo::bar
function! puppet#PathToClassName(...)
  if a:0
    let path = a:1
  else
    let path = expand('%:p')
  endif

  let suffix = util#path#RemovePrefix('/modules/', path)

  if suffix ==# path
    let suffix = fnamemodify(suffix, ':t')
  endif

  let suffix = substitute(suffix, '/manifests/', '/', '')

  return substitute(fnamemodify(suffix, ':r'), '/', '::', 'g')
endfunction

" vim: fdm=marker:sw=2:sts=2:et
