" spore.vim - Spore plug-in manager support for use inside Vim
" Maintainer:   Noah Frederick

let s:spore_executable = 'spore'
let s:spore_buffer_commands = [
  \ '(u)pdate plug-in',
  \ '(U)pdate all',
  \ '(D)elete',
  \ '(i)nstall',
  \ '(r)efresh',
  \ '(q)uit',
  \ ]

function! s:buffer_setup()
  tabnew
  setlocal buftype=nofile bufhidden=wipe noswapfile nowrap nonumber nospell
  setf spore
endfunction

function! s:get_listing()
  execute join(['2read !', s:spore_executable, 'list'])
  echo
endfunction

function! s:get_bundle_url(bundle)
  return join(['https://github.com/', a:bundle], '')
endfunction

function! spore#current_bundle()
  let l:words = split(getline('.'))
  if len(l:words) > 1
    return l:words[1]
  endif
endfunction

function! spore#browse(bundle)
  if a:bundle ==# ''
    return
  endif
  let l:url = s:get_bundle_url(a:bundle)
  call netrw#NetrwBrowseX(l:url, 0)
endfunction

function! spore#update(bundle)
  if a:bundle ==# ''
    return
  endif
  return spore#exec(join(['update', a:bundle]))
endfunction

function! spore#update_all()
  return spore#exec('update')
endfunction

function! spore#install(bundle)
  if a:bundle ==# ''
    return
  endif
  silent call spore#exec(join(['install', a:bundle]))
  redraw!
  call spore#refresh()
endfunction

function! spore#uninstall(bundle)
  if a:bundle ==# ''
    return
  endif
  silent call spore#exec(join(['uninstall', a:bundle]))
  redraw!
  call spore#refresh()
endfunction

function! spore#exec(args)
  if executable(s:spore_executable) < 1
    echoerr 'Executable not found: make sure ' . s:spore_executable . ' is in PATH'
    return
  endif

  if a:args ==# ''
    return spore#list()
  endif

  execute join(['!', s:spore_executable, a:args])
endfunction

function! spore#refresh()
  let l:saved_view = winsaveview()
  set modifiable
  3,$delete _
  call s:get_listing()
  call winrestview(l:saved_view)
  set nomodifiable
endfunction

function! spore#list()
  set modifiable
  call s:buffer_setup()
  " Populate buffer
  call append(0, '" ' . join(s:spore_buffer_commands, '  '))
  call s:get_listing()
  set nomodifiable

  " Place cursor on first plug-in line
  3
endfunction

" vim: fdm=marker:sw=2:sts=2:et
