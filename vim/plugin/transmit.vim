" transmit.vim - FTP current file via Transmit.app
" Maintainer:   Noah Frederick
"
" Based on: https://github.com/abeaumet/transmit.vim
"
" With various enhancements including a command for uploading the compiled
" version of the current file instead (e.g., style.less => style.css)
"
" I wrote this immediately before discovering
" https://github.com/hlissner/vim-transmitty which does very much the same
" thing.

if exists("g:loaded_transmit") || v:version < 700 || &cp || !executable('osascript')
  finish
endif
let g:loaded_transmit = 1

function! s:Transmit(bang, path) abort
  let l:path = (a:path ==# '') ? expand("%") : a:path

  if l:path == ''
    echoerr "Failed to send a file to Transmit (can't expand filename)"
    return
  endif

  let l:path = fnamemodify(l:path, ':p')

  call s:TransmitSendFile(l:path, a:bang)
endfunction

function! s:TransmitAlternate(bang, path) abort
  let l:path = (a:path ==# '') ? expand("%") : a:path

  if l:path == ''
    echoerr "Failed to send a file to Transmit (can't expand filename)"
    return
  endif

  let l:path = helper#path#CompiledVersion(l:path)
  let l:path = fnamemodify(l:path, ':p')

  if !filereadable(l:path)
    echoerr "Alternate file not readable: " . l:path
    return
  endif

  call s:TransmitSendFile(l:path, a:bang)
endfunction

" Send a file to Transmit.app.
"
" The process is aborted if the current buffer is modified unless the bang
" parameter is non-empty.
function! s:TransmitSendFile(path, bang) abort
  if a:bang == '' && &modified
    echoerr "There are unwritten changes. Save your file or add ! to upload it anyway."
    return
  endif

  call s:TransmitDoApplescript(a:path)
  echo 'File "' . a:path . '" sent to Transmit'
endfunction

" Open path in Transmit with Applescript.
"
" Note that Transmit must have the appropriate connection open and DockSend
" must be enabled.
function! s:TransmitDoApplescript(path) abort
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

command! -nargs=? -bang -bar -complete=file Transmit call <SID>Transmit(<q-bang>, <q-args>)
command! -nargs=? -bang -bar -complete=file TransmitAlternate call <SID>TransmitAlternate(<q-bang>, <q-args>)

" vim: fdm=marker:sw=2:sts=2:et
