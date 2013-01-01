" General settings
set cursorline

augroup CursorLine
  autocmd!

  " Only highlight cursor line in active buffer window
  autocmd WinLeave * set nocursorline
  autocmd WinEnter * set cursorline
augroup END

" Set colors
set transparency=10

" Set font
set guifont=Panic\ Sans:h12

" Panic Sans needs a little vertical breathing room
set linespace=2

" Hide toolbar and scrollbars by default
" (see :help guioptions for expanation)
set guioptions=gmt

