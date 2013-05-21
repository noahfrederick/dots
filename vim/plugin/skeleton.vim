" Skeleton:    Read in template based on file type
" Maintainer:  Noah Frederick (http://noahfrederick.com)
" Notes:       Based on tpope's ztemplate.vim and godlygeek's snippets.vim
"              https://github.com/tpope/tpope/blob/master/.vim/plugin/ztemplate.vim
"              https://github.com/godlygeek/vim-files/blob/master/plugin/snippets.vim

if (exists("g:loaded_skeleton") && g:loaded_skeleton) || &cp
  finish
endif
let g:loaded_skeleton = 1


augroup Skeleton
  autocmd!
  autocmd BufNewFile * call s:LoadByFilename(expand("<amatch>"))
  autocmd FileType   * call s:LoadByFiletype(expand("<amatch>"), expand("<afile>"))
augroup END


function! s:LoadByFilename(filename)
  let ext = fnamemodify(a:filename, ':e')
  if ext == ''
    let ext = (fnamemodify(a:filename, ':t'))
  endif
  if ext =~ '['
    return
  endif
  call s:Load(ext, a:filename)
endfunction


function! s:LoadByFiletype(type, filename)
  if a:type == "python"
    let ext = "py"
  elseif a:type == "ruby"
    let ext = "rb"
  else
    let ext = a:type
  endif
  call s:Load(ext, a:filename)
endfunction


function! s:Load(type, filename)
  " Abort if buffer is non-empty or file already exists
  if ! (line("$") == 1 && getline("$") == "") || filereadable(a:filename)
    return
  endif

  let template = a:type
  " Look for template named after containing directory with extension
  if ! s:ReadTemplate(substitute(fnamemodify(a:filename, ':h:t'), '\W', '_', 'g').".".template)
    " Look for generic template with extension
    if ! s:ReadTemplate("skel.".template)
      return
    endif
  endif

  let filename = fnamemodify(a:filename, ':t')
  let basename = fnamemodify(a:filename, ':t:r')
  let name     = substitute(basename, '\C\(\l\)\(\u\|\d\)', '\1_\l\2', 'g')
  let name     = substitute(name, '^.', '\u&', 'g')
  if !exists("g:template_title")
    let title  = substitute(name, '_\(.\)', ' \u\1', 'g')
  else
    let title  = g:template_title
    unlet g:template_title
  endif
  let name     = substitute(name, '_\(.\)', ' \1', 'g')

  if !exists("g:template_email")
    let g:template_email = system('git config --get user.email')[0:-2]
  endif
  if !exists("g:template_author")
    let g:template_author = system('git config --get user.name')[0:-2]
    if g:template_author == ""
      let g:template_author = exists("$USER") ? $USER : ""
    endif
  endif

  call s:Replace("EMAIL", g:template_email)
  call s:Replace("AUTHOR", g:template_author)
  call s:Replace("FILENAME", filename)
  call s:Replace("BASENAME", basename)
  call s:Replace("TITLE", title)
  call s:Replace("DATE", strftime("%a, %d %b %Y"))
  call s:Replace("YEAR", strftime("%Y"))

  normal! zn
  $ delete
  if line('$') > &lines
    1
  endif

  call s:Replace("CURSOR", "")
endfunction


function! s:ReadTemplate(filename)
  let b:template_file = "~/.vim/templates/".a:filename
  if !filereadable(expand(b:template_file))
    return 0
  endif
  let cpopts = &cpoptions
  set cpoptions-=a
  silent execute "0r ".b:template_file
  let &cpoptions = cpopts
  return 1
endfunction


function! s:EditCurrentTemplate()
  if !exists("b:template_file")
    echoerr "No template is associated with this buffer"
    return
  endif
  execute "e ".b:template_file
endfunction

command! SkelEdit call s:EditCurrentTemplate()


function! s:Replace(placeholder, replacement)
  silent! execute '%s/@'.a:placeholder.'@/'.a:replacement.'/g'
endfunction

