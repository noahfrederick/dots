" autoload/my/snippets.vim - Global helpers for snippets
" Maintainer:   Noah Frederick

function! my#snippet#title(basename)
  if exists("g:template_title")
    " Setting g:template_title lets us override the title (once)
    let title = g:template_title
    unlet g:template_title
    return title
  endif

  if exists("b:template_title")
    " Setting b:template_title also lets us override the title
    return b:template_title
  endif

  if a:basename =~# '\v\.(n?vimrc|exrc)$'
    return 'Local configuration'
  end

  " Otherwise derive from file's basename
  let title = substitute(a:basename, '\C\(\l\)\(\u\|\d\)', '\1_\l\2', 'g')
  let title = substitute(title, '^.', '\u&', 'g')
  let title = substitute(title, '_\(.\)', ' \u\1', 'g')
  return title
endfunction

function! my#snippet#expand_snippet_or_complete_maybe()
  call UltiSnips#ExpandSnippetOrJump()

  if !exists("g:ulti_expand_or_jump_res") || g:ulti_expand_or_jump_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      return "\<Tab>"
    endif
  endif

  return ""
endfunction

function! s:try_insert(skel)
  execute "normal! i_" . a:skel . "\<C-r>=UltiSnips#ExpandSnippet()\<CR>"

  if g:ulti_expand_res == 0
    silent! undo
  endif

  return g:ulti_expand_res
endfunction

""
" Make u undo twice (temporarily) to work around UltiSnip's undo-breaking
" anti-feature.
function! s:install_undo_workaround() abort
  nnoremap <silent><buffer> u :call <SID>undo_workaround()<CR>
endfunction

function! s:undo_workaround() abort
  normal! 2u
  nunmap <buffer> u
endfunction

function! my#snippet#insert_skeleton() abort
  " Load UltiSnips in case it was deferred via vim-plug
  if !exists('g:did_plugin_ultisnips') && exists(':PlugStatus')
    call plug#load('ultisnips')
    doautocmd FileType
  endif

  " Abort on non-empty buffer or extant file
  if !exists('g:did_plugin_ultisnips') || !(line('$') == 1 && getline('$') == '') || filereadable(expand('%:p'))
    return
  endif

  if !empty(b:projectionist)
    " Loop through projections with 'skeleton' key and try each one until the
    " snippet expands
    for [root, value] in projectionist#query('skeleton')
      if s:try_insert(value)
        call s:install_undo_workaround()
        return
      endif
    endfor
  endif

  " Try generic _skel template as last resort
  if s:try_insert("skel")
    call s:install_undo_workaround()
  endif
endfunction

" vim:set et sw=2:
