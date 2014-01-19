" spore.vim - Spore plug-in manager support for use inside Vim
" Maintainer:   Noah Frederick

let s:spore_executable = expand('~/.vim/spore/spore')

function! s:buffer_setup()
  tabnew
  setlocal buftype=nofile bufhidden=wipe noswapfile nowrap nonumber nospell
  setf spore
endfunction

function! s:get_listing()
  execute join(['2read !', s:spore_executable, 'list'])
  2delete _
endfunction

function! spore#exec(args)
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
  call append(0, '" (u)pdate plug-in  (U)pdate all  (D)elete  (R)estore  (r)efresh  (q)uit')
  call s:get_listing()
  set nomodifiable

  " Place cursor on first plug-in line
  4
endfunction

" vim: fdm=marker:sw=2:sts=2:et
