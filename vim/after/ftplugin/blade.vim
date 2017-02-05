let b:surround_{char2nr('=')} = "{{ \r }}"
let b:surround_{char2nr('/')} = "{{-- \r --}}"
let b:surround_{char2nr('!')} = "{!! \r !!}"
let b:surround_{char2nr('d')} = "@\1Blade directive: @\1 \r @end\1\r\[( \]\\+.*\r\1"
let b:surround_{char2nr('D')} = b:surround_{char2nr('d')}
let b:surround_{char2nr('@')} = b:surround_{char2nr('d')}
