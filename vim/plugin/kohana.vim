" kohana.vim - Kohana PHP Framework for Vim
" Maintainer:   Noah Frederick

if exists("g:loaded_kohana") || v:version < 700 || &cp
  finish
endif
let g:loaded_kohana = 1

function! s:sub(str, pat, rep) abort
  return substitute(a:str, '\v\C' . a:pat, a:rep, '')
endfunction

function! s:gsub(str, pat, rep) abort
  return substitute(a:str, '\v\C' . a:pat, a:rep, 'g')
endfunction

let s:commands = []
function! s:command(definition) abort
  let s:commands += [a:definition]
endfunction

function! s:define_commands()
  for command in s:commands
    exe 'command! -buffer ' . command
  endfor
endfunction

augroup kohana
  autocmd!
  autocmd User Kohana execute 'lcd ' . b:kohana_root
  autocmd User Kohana call s:define_commands()
augroup END

function! kohana#is_system_dir(path) abort
  let path = s:sub(a:path, '[\/]$', '') . '/'
  return isdirectory(path . 'classes/Kohana')
endfunction

function! kohana#extract_root(path) abort
  let root = simplify(fnamemodify(a:path, ':p:s?[\/]$??'))
  let previous = ''
  while root !=# previous
    let dir = s:sub(root, '[\/]$', '') . '/system'
    if isdirectory(dir) && kohana#is_system_dir(dir)
      return root
    endif
    let previous = root
    let root = fnamemodify(root, ':h')
  endwhile
  return ''
endfunction

function! kohana#detect(path)
  if exists('b:kohana_root') && (b:kohana_root ==# '' || b:kohana_root =~# '/$')
    unlet b:kohana_root
  endif
  if !exists('b:kohana_root')
    let dir = kohana#extract_root(a:path)
    if dir !=# ''
      let b:kohana_root = dir
    endif
  endif
  if exists('b:kohana_root')
    silent doautocmd User Kohana
  endif
endfunction

augroup kohana
  autocmd BufNewFile,BufReadPost * call kohana#detect(expand('<amatch>:p'))
  autocmd FileType           netrw call kohana#detect(expand('%:p'))
  autocmd User NERDTreeInit,NERDTreeNewRoot call kohana#detect(b:NERDTreeRoot.path.str())
  autocmd VimEnter * if expand('<amatch>')==''|call kohana#detect(getcwd())|endif
augroup END

" TODO Parse these from configuration in index.php?
function! kohana#get_system_dir()
  if !exists('b:kohana_system')
    let b:kohana_system = b:kohana_root . '/system'
  endif
  return b:kohana_system
endfunction

function! kohana#get_modules_dir()
  if !exists('b:kohana_modules')
    let b:kohana_modules = b:kohana_root . '/modules'
  endif
  return b:kohana_modules
endfunction

function! kohana#get_application_dir()
  if !exists('b:kohana_application')
    let b:kohana_application = b:kohana_root . '/application'
  endif
  return b:kohana_application
endfunction

function! kohana#get_config_dir()
  return kohana#get_application_dir() . '/config'
endfunction

function! kohana#get_messages_dir()
  return kohana#get_application_dir() . '/messages'
endfunction

function! kohana#get_templates_dir()
  return kohana#get_application_dir() . '/templates'
endfunction

function! kohana#get_config_file(file)
  return kohana#get_config_dir() . '/' . a:file . '.php'
endfunction

function! kohana#get_message_file(file)
  return kohana#get_messages_dir() . '/' . a:file . '.php'
endfunction

function! kohana#get_template_file(file)
  return kohana#get_templates_dir() . '/' . a:file . '.php'
endfunction

function! kohana#get_bootstrap_file()
  return kohana#get_application_dir() . '/bootstrap.php'
endfunction

function! kohana#edit_config_file(cmd, bang, file)
  return a:cmd . a:bang . ' ' . kohana#get_config_file(a:file)
endfunction

function! kohana#edit_message_file(cmd, bang, file)
  return a:cmd . a:bang . ' ' . kohana#get_message_file(a:file)
endfunction

function! kohana#edit_template_file(cmd, bang, file)
  return a:cmd . a:bang . ' ' . kohana#get_template_file(a:file)
endfunction

call s:command('-nargs=0 -bang Kbootstrap execute "edit<bang> " . kohana#get_bootstrap_file()')
for s:type in ['config', 'message', 'template']
  call s:command('-nargs=1 -bang -complete=customlist,kohana#command_complete_' . s:type . ' K' . s:type . ' execute kohana#edit_' . s:type . '_file("edit", <q-bang>, <q-args>)')
endfor

function! kohana#command_complete_config(A, L, P)
  return kohana#command_complete_path(kohana#get_config_dir(), a:A, a:L, a:P)
endfunction

function! kohana#command_complete_message(A, L, P)
  return kohana#command_complete_path(kohana#get_messages_dir(), a:A, a:L, a:P)
endfunction

function! kohana#command_complete_template(A, L, P)
  return kohana#command_complete_path(kohana#get_templates_dir(), a:A, a:L, a:P)
endfunction

function! kohana#command_complete_path(path_prefix, A, L, P)
  let matches = split(globpath(a:path_prefix, '**/' . a:A . '*.php'), "\n")
  return map(matches, 'fnamemodify(v:val, ":s?'.a:path_prefix.'/??:r")')
endfunction

" vim: fdm=marker:sw=2:sts=2:et
