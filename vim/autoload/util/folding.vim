" autoload/util/foldtext.vim - Clean fold text for the minimalist
" Adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
"
" Assuming your fold fillchar is "-", it produces folds that look like this:
"
" +-- public function example() { ... } ------------------------------   20 lines ----
" +-- public function folding($len, $char) { ... } -------------------  143 lines ----
"
" (Try using <Space> instead for fold minimalism: set fillchars=fold:\ )
"
" Features:
"   - In very narrow windows, the line count is omitted.
"   - The original indentation of the preview text is preserved.
"   - Matching brackets are collapsed to "{ ... }".
"
function! util#folding#Text()
  let line = substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{{\d*\s*', '', 'g')

  if line =~ '\s*{\s*' && getline(v:foldend) =~ '^\s*}\s*'
    let line .= ' ... }'
  endif

  let line .= ' '

  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldchar = (foldchar == '') ? ' ' : foldchar

  if winwidth(0) > 60
    let lines = v:foldend - v:foldstart + 1
    let foldtextend = ' ' . printf('%10s', lines . ' lines') . ' ' . repeat(foldchar, 4)
  else
    let foldtextend = ''
  endif

  let gutterlen = &foldcolumn + &numberwidth

  let foldindent = (v:foldlevel - 1) * s:shiftwidth()
  let foldprefix = foldindent > 0 ? '+' . repeat(foldchar, foldindent - 2) . ' ' : ''
  let foldtextstart = strpart(foldprefix . line, 0, winwidth(0) - strlen(foldtextend) - gutterlen)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + gutterlen

  return foldtextstart . repeat(foldchar, winwidth(0) - foldtextlength) . foldtextend
endfunction

" Get the effective value of 'shiftwidth'. Newer Vims allow a value of 0,
" which uses the value of 'tabstop', in which case we need to use the
" shiftwidth() function.
if exists('*shiftwidth')
  function! s:shiftwidth()
    return shiftwidth()
  endfunction
else
  function! s:shiftwidth()
    return &shiftwidth
  endfunction
endif
" vim: fdm=marker:sw=2:sts=2:et
