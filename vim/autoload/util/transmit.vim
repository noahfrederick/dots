" autoload/util/transmit.vim - FTP current file via Transmit.app
" Maintainer:   Noah Frederick
"
" This plug-in exposes a single :Transmit command, which sends the current
" file to Transmit.app for transfer. It translates uncompiled assets such as
" LESS or SASS files to their compiled versions and uploads those instead.
"
" Prior work:
" - https://github.com/abeaumet/transmit.vim
" - https://github.com/hlissner/vim-transmitty

" Send the specified (or current buffer's) file to Transmit.app
"
" The process is aborted if the current buffer is modified unless the bang
" parameter is non-empty.
function! util#transmit#Send(bang, path) abort
  if a:path ==# ''
    if a:bang == '' && &modified
      echoerr "There are unwritten changes. Save your file or add ! to upload it anyway."
      return
    endif

    let l:path = expand("%")
  else
    let l:path = a:path
  endif

  if l:path == ''
    echoerr "Failed to send file to Transmit (can't expand filename)"
    return
  endif

  let l:alternate = util#path#CompiledVersion(l:path)

  if filereadable(l:alternate)
    let l:path = l:alternate
  endif

  call s:transmit_send_file(l:path)
endfunction

" Send a file to Transmit.app.
function! s:transmit_send_file(path) abort
  let l:path = fnamemodify(a:path, ':p')
  call s:transmit_do_applescript(l:path)
  echomsg 'File "' . a:path . '" sent to Transmit'
endfunction

" Open path in Transmit with Applescript.
"
" Note that DockSend must be enabled for the appropriate connection, which is
" established based on the file location (in must be the descendant of a
" configured website root).
function! s:transmit_do_applescript(path) abort
  let l:commands = ''
  let l:commands .= ' -e "set filepath to \"' . a:path . '\""'
  let l:commands .= ' -e "set filename to POSIX file filepath"'
  let l:commands .= ' -e "ignoring application responses"'
  let l:commands .= ' -e   "tell application \"Transmit\""'
  let l:commands .= ' -e     "open filename"'
  let l:commands .= ' -e   "end tell"'
  let l:commands .= ' -e "end ignoring"'

  silent execute '!osascript ' . l:commands . ' &>/dev/null &'
  redraw!
endfunction

" vim: fdm=marker:sw=2:sts=2:et
