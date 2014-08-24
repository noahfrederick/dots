" autoload/util/test.vim - Helpers for vspec tests

" Read sample file with {ext} into the buffer
function! util#test#ReadFixture(ext)
  read `='t/fixtures/sample.' . a:ext`
endfunction

" Do a visual selection using {object} at {line_number} and report on the
" resulting selection
function! util#test#SelectTextObject(line_number, object)
  call cursor(a:line_number, 1)
  execute 'normal' 'v'.a:object."\<Esc>"
  return [visualmode(), line("'<"), line("'>")]
endfunction
