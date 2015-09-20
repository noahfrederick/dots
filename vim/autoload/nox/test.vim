" autoload/nox/test.vim - Helpers for vspec tests

" Read sample file with {ext} into the buffer
function! nox#test#read_fixture(ext)
  read `='t/fixtures/sample.' . a:ext`
endfunction

" Do a visual selection using {object} at {line_number} and report on the
" resulting selection
function! nox#test#select_text_object(line_number, object)
  call cursor(a:line_number, 1)
  execute 'normal' 'v'.a:object."\<Esc>"
  return [visualmode(), line("'<"), line("'>")]
endfunction
