" ftplugin/php.vim - Settings for PHP including snippet helpers

" Use :make to check PHP syntax
setlocal makeprg=php\ -l\ % errorformat=%m\ in\ %f\ on\ line\ %l

" Settings for bundled PHP plug-in
let g:php_noShortTags = 1         " Always use <?php

let b:php_source_prefixes = [
  \ 'application/classes/',
  \ 'application/tests/',
  \ 'src/main/php/',
  \ 'src/main/',
  \ 'src/',
  \ 'lib/',
  \ ]

" Infer the PSR-0 class name from file's path.
" Example:
"   classes/HTTP/Request.php -> HTTP_Request
function! PathToClassName(path)
  let l:path = a:path
  for l:prefix in b:php_source_prefixes
    if stridx(l:path, l:prefix) == 0
        let l:path = strpart(l:path, strlen(l:prefix))
        break
    endif
  endfor
  return substitute(fnamemodify(l:path, ":r"), '/', '_', 'g')
endfunction

" Make an intelligent guess about the parent class name based on file's path.
function! PathToParentClassName(path)
  let l:path = a:path
  if stridx(l:path, "/tests/") != -1
    return "PHPUnit_Framework_TestCase"
  endif
  return "ParentClass"
endfunction

" Derive class name from test class name
" Example:
"   HTTP_RequestTest -> HTTP_Request
function! TestClassNameToClassName(className)
  return substitute(a:className, 'Test$', '', '')
endfunction

" Derive test class name from class name
" Example:
"   HTTP_Request -> HTTP_RequestTest
function! ClassNameToTestClassName(className)
  return a:className.'Test'
endfunction

" Generate a generic description for test case
function! GetTestCaseDescription()
  let className = PathToClassName()
  let className = TestClassNameToClassName(className)

  return 'Test case for class '.className
endfunction

" vim: fdm=marker:sw=2:sts=2:et
