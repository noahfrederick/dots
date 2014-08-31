" autoload/php.vim - PHP helpers

let s:php_source_prefixes = [
  \ 'application/classes/',
  \ 'application/tests/',
  \ 'src/main/php/',
  \ 'src/main/',
  \ 'src/',
  \ 'lib/',
  \ ]

let s:php_source_segments = [
  \ ['/tests/', 'Tests'],
  \ ['/Controller/', 'Controllers'],
  \ ['/Model/', 'Models'],
  \ ['/Task/', 'Tasks'],
  \ ['/View/', 'Views'],
  \ ]

" Get cascading key value from projection
function! s:projection_query(key)
  for [root, value] in projectionist#query(a:key)
    return value
  endfor
  return ""
endfunction

" Get the opening PHP tag with guard, if any
function! php#Open()
  let parts = ["<?php"]

  if s:projection_query("framework") ==# "kohana"
    if s:projection_query("category") == "Tests"
      let parts = add(parts, "defined('SYSPATH') OR die('Kohana bootstrap needs to be included before tests run');")
    else
      let parts = add(parts, "defined('SYSPATH') OR die('No direct script access.');")
    endif
  endif

  return join(parts)
endfunction

""
" Infer the PSR-0 class name from file's path.
"
" Example:
"   classes/HTTP/Request.php -> HTTP_Request
function! php#PathToClassName(...)
  if a:0
    let path = a:1
  else
    let path = expand('%:p')
  endif

  let path = util#path#RemovePrefix(s:php_source_prefixes, path)

  if suffix ==# path
    let suffix = fnamemodify(path, ':t')
  endif

  return substitute(fnamemodify(suffix, ':r'), '/', '_', 'g')
endfunction

" Make an intelligent guess about the parent class name based on file's path.
function! php#PathToParentClassName(path)
  if s:projection_query("category") ==# "Tests"
    return "PHPUnit_Framework_TestCase"
  endif

  return "ParentClass"
endfunction

" Derive class name from test class name
" Example:
"   HTTP_RequestTest -> HTTP_Request
function! php#TestClassNameToClassName(className)
  return substitute(a:className, 'Test$', '', '')
endfunction

" Derive test class name from class name
" Example:
"   HTTP_Request -> HTTP_RequestTest
function! php#ClassNameToTestClassName(className)
  return a:className.'Test'
endfunction

" Generate a generic description for test case
function! php#GetTestCaseDescription()
  let className = php#PathToClassName()
  let className = php#TestClassNameToClassName(className)

  return 'Test case for class '.className
endfunction

" Derive class category from file's path
function! php#PathToClassCategory(path)
  for [segment, category] in s:php_source_segments
    if stridx(a:path, l:segment) != -1
      return l:category
    endif
  endfor
  return "Helpers"
endfunction

" Function text objects
function! php#FunctionSelect(object_type)
  return s:function_select_{a:object_type}()
endfunction

function! s:function_select_a()
  if getline('.') =~# '}'
    normal! k
  endif
  normal! ]M$
  let e = getpos('.')

  normal! [m
  call search(')', 'bW')
  normal! %0
  let b = getpos('.')

  if 1 < e[1] - b[1]  " is there some code?
    return ['V', b, e]
  else
    return 0
  endif
endfunction

function! s:function_select_i()
  let range = s:function_select_a()
  if range is 0
    return 0
  endif

  let [_, ab, ae] = range

  call setpos('.', ab)
  call search('{', 'W')
  normal! j0
  let ib = getpos('.')

  call setpos('.', ae)
  normal! k$
  let ie = getpos('.')

  if 0 <= ie[1] - ib[1]  " is there some code?
    return ['V', ib, ie]
  else
    return 0
  endif
endfunction

" vim: fdm=marker:sw=2:sts=2:et
