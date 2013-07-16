" GENERAL SETTINGS                                                             {{{
" --------------------------------------------------------------------------------

set nocompatible                " Disable Vi compatibility

if filereadable($HOME."/.vim/bundle/pathogen/autoload/pathogen.vim")
  runtime bundle/pathogen/autoload/pathogen.vim
  call pathogen#infect()        " Manage plug-ins with pathogen.vim
endif

if has("autocmd")
  filetype plugin indent on     " File-type detection, plug-ins, indent scripts
endif
if has("syntax") && !exists("g:syntax_on")
  syntax enable                 " Enable syntax highlighting
endif
if &t_Co >= 16
  silent! colorscheme noctu     " Set color scheme for 16-color+ terminals
endif

if &shell =~# "fish$"
  set shell=/bin/bash           " Ensure shell is POSIX compatible
endif

set encoding=utf-8              " Use UTF-8 as default file encoding
set spelllang=en_us             " Language and region to use for spellchecking
set shortmess+=I                " Suppress intro message when starting Vim
set laststatus=2                " Always show status line
set ruler                       " Show cursor position if status line not visible
set modeline modelines=5        " Look for modeline at beginning/end of file
set autoread                    " Reload unchanged buffer when file changes
set history=500                 " Keep 500 lines of history
set scrolloff=2                 " Keep lines above/below cursor visible
set sidescrolloff=5             " Keep columns left/right of cursor visible
set display+=lastline           " Show as much as possible of wrapped last line
set foldnestmax=3               " Limit depth of nested syntax/indent folds
set foldopen-=block             " Do not open folds on "(", "{", etc.
set helpheight=1000             " Maximize help window vertically
set lazyredraw                  " Do not redraw screen during macro execution
set fillchars=vert:\            " Use space for vertical split fill char
if has("linebreak")             " Wrap lines at word boundaries
  set linebreak
  set showbreak=...
endif
set nowrap                      " Do not wrap long lines by default
set listchars=tab:>\ ,eol:$,extends:>,precedes:<,nbsp:+
if &termencoding ==# "utf-8" || &encoding ==# "utf-8"
  let &fillchars = "vert:\u2502" | highlight VertSplit ctermbg=NONE guibg=NONE
  let &listchars = "tab:\u25b8 ,eol:\u00ac,extends:\u276f,precedes:\u276e,nbsp:\u2334"
  if has("linebreak")
    let &showbreak = "\u21aa"
  endif
endif

if has("unnamedplus")
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

"" Command line and completion
set wildmenu                    " Command line completion
set cmdheight=2                 " Reserve two lines for command area
set completeopt+=longest        " Only insert longest common string
set pumheight=8                 " Limit height of popup menu

"" Whitespace
set autoindent
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set tabstop=4                   " Width of displayed tabs--the rest is taken care of by sleuth.vim
set shiftround                  " Round indent to multiple of 'shiftwidth'

"" Swaps and backups
if !strlen($SUDO_USER) && has("unix")
  " Don't store swaps in . -- store in ~/.vim/tmp/%path%to%orig.swp
  set directory=~/.vim/tmp//,.,/var/tmp
  " Don't store backups in . -- store in ~/.vim/tmp/%path%to%orig~
  set backupdir=~/.vim/tmp//,.,/var/tmp
  " Create tmp/ dir if it doesn't exist
  if !isdirectory($HOME."/.vim/tmp") && exists("*mkdir")
    call mkdir($HOME."/.vim/tmp", "p", 0700)
  endif
else
  set nobackup
  set nowritebackup
  set noswapfile
endif

"" Searching
set hlsearch                    " Highlight search matches
set incsearch                   " Do incremental searching
set smartcase                   " Case-sensitivity triggered by capital letter if 'ignorecase' set

let g:statusline_separator_left = " \u27e9 "
let g:statusline_separator_right = " \u27e8 "

let &statusline = ""
let &statusline .= " %6.(#%n%) ".g:statusline_separator_left
let &statusline .= "%t"
let &statusline .= ' %{exists("*fugitive#statusline")?fugitive#statusline()[4:-2]:""}'
let &statusline .= "%m%="
let &statusline .= "%{strlen(&fenc)?&enc:&fenc}".g:statusline_separator_right
let &statusline .= '%{strlen(&ft)?&ft:"n/a"}'.g:statusline_separator_right
let &statusline .= "%3.l:%-3.c "

" In many terminal emulators the mouse works just fine, thus enable it.
if has("mouse")
  set mouse=a
endif

" Load matchit.vim, if a newer version isn't already installed
if !exists("g:loaded_matchit") && findfile("plugin/matchit.vim", &rtp) ==# ""
  runtime! macros/matchit.vim
endif

" }}}
" FUNCTIONS & COMMANDS                                                         {{{
" --------------------------------------------------------------------------------

" Show highlight group of character under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line("."), col(".")), "synIDattr(v:val, 'name')")
endfunction

" Follow symlink to actual file
function! <SID>FollowSymlink()
  " Get path of actual file
  let fname = resolve(expand("%:p"))
  " Rename buffer with new path
  execute "file " . fname
  " Read file again to trigger any plug-ins that are context-sensitive
  edit
endfunction

if !exists(":FollowSymlink")
  command FollowSymlink call <SID>FollowSymlink()
endif

" Execute commands without moving cursor, changing search pattern
function! <SID>Preserve(...)
  let l:saved_search = @/
  let l:saved_pos = getpos('.')
  for l:command in a:000
    execute l:command
  endfor
  call setpos('.', l:saved_pos)
  let @/ = l:saved_search
endfunction

function! <SID>NormalizeWhitespace()
  " 1. Strip trailing whitespace
  " 2. Merge consecutive blank lines
  " 3. Strip empty line from end of file
  call <SID>Preserve(
    \ '%substitute/\s\+$//e',
    \ '%substitute/\n\{3,}/\r\r/e',
    \ '%substitute/\n\+\%$//e'
    \ )
endfunction

function! <SID>Bdelete(bang) abort
  let l:current_buffer = bufnr("%")
  let l:alternate_buffer = bufnr("#")

  if buflisted(l:alternate_buffer)
    execute "buffer" . a:bang . " #"
  else
    execute "bnext" . a:bang
  endif

  if bufnr("%") == l:current_buffer
    new
  endif

  if buflisted(l:current_buffer)
    execute "bdelete" . a:bang . " " . l:current_buffer
  endif
endfunction

if !exists(":Bdelete")
  command -bang -bar Bdelete call <SID>Bdelete(<q-bang>)
endif

if exists("$BLOG")
  " Create a new Jekyll post in _drafts/
  function! <SID>PostNew(title, bang)
    let g:template_title = a:title
    let file = "$BLOG/_drafts/" . tolower(substitute(a:title, "\\W\\+", "-", "g")) . ".md"
    execute "edit" . a:bang . " " . fnameescape(file)
    set filetype=liquid
  endfunction

  " Move the current draft into _posts/ and prepend date to filename
  function! <SID>PostPublish()
    if expand("%:p:h") !~# '/_drafts$'
      echoerr "This does not appear to be a draft blog post"
      return
    endif
    write
    " Note: relies on eunuch-:Move command
    exec "Move $BLOG/_posts/" . strftime("%Y-%m-%d") . "-" . expand("%:p:t")
  endfunction

  command! -nargs=1 -bang PostNew call <SID>PostNew(<q-args>, <q-bang>)
  command! -bar PostPublish call <SID>PostPublish()
endif

if exists("$NOTES")
  command! -bang Today execute "edit<bang> $NOTES/" . strftime("%Y-%m-%d") . ".md<Bar>lcd %:p:h"
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vertical new | set buftype=nofile | read # | 0delete_
    \ | diffthis | wincmd p | diffthis
endif

" }}}
" AUTOCOMMANDS                                                                 {{{
" --------------------------------------------------------------------------------

if has("autocmd")
  augroup FileTypeOptions
    autocmd!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text,markdown setlocal textwidth=78 wrap
    autocmd FileType markdown silent! compiler pandoc

    " Always use spelling for particular file types
    autocmd FileType gitcommit setlocal spell

    " Append semicolon or comma to end of line in insert mode
    autocmd FileType c,cpp,css,javascript,php inoremap <buffer> ;; <Esc>A;
    autocmd FileType c,cpp,css,javascript,php inoremap <buffer> ,, <Esc>A,
    autocmd FileType php,ruby inoremap <buffer> >> <Space>=><Space>

    " Automatically complete closing tags
    autocmd FileType html,liquid,markdown,php,xml inoremap <buffer> </ </<C-x><C-o>
    autocmd FileType html,liquid,xml setlocal textwidth=120

    " Do not wrap lines in the QuickFix window
    autocmd FileType qf setlocal nowrap

    " Set format options for Apache config files
    autocmd FileType apache setlocal comments=:# commentstring=#\ %s
      \ formatoptions-=t formatoptions+=croql

    " Set options for fish scripts
    autocmd FileType fish silent! compiler fish
    autocmd FileType fish setlocal textwidth=78 foldmethod=expr

    " Set the file type for common Ruby files not ending in .rb
    autocmd BufRead,BufNewFile {Rakefile} set filetype=ruby
  augroup END

  set cursorline
  augroup CursorLine
    autocmd!

    " Only highlight cursor line in active buffer window
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline
  augroup END

  highlight! link TrailingWhitespace Error
  augroup TrailingWhiteSpace
    autocmd!
    autocmd BufWinEnter * if &modifiable | match TrailingWhitespace /\s\+$/ | endif
    autocmd InsertEnter * if &modifiable | match TrailingWhitespace /\s\+\%#\@<!$/ | endif
    autocmd InsertLeave * if &modifiable | match TrailingWhitespace /\s\+$/ | endif
    autocmd BufWinLeave * if &modifiable | call clearmatches() | endif
  augroup END
endif

" }}}
" MAPPINGS                                                                     {{{
" --------------------------------------------------------------------------------

" Make Y consistent with C and D
nnoremap Y y$

noremap <Down> <C-w>+
noremap <Up> <C-w>-
noremap <Left> <C-w><
noremap <Right> <C-w>>

" Turn off highlighting and clear any message already displayed
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

" Expand %% to directory of current file in command-line mode
cnoremap %% <C-r>=fnameescape(expand("%:h"))."/"<CR>

" Convenient ways to open files relative to current buffer
map <Leader>ew :edit %%
map <Leader>es :split %%
map <Leader>ev :vsplit %%
map <Leader>et :tabedit %%

" Toggle light/dark background
nnoremap <Leader>k :let &background = ( &background == "dark" ? "light" : "dark" )<CR>

" :help dispatch-commands
nnoremap <F2> :Make<CR>
nnoremap <F3> :Dispatch<CR>

" Write buffer and source current file
nnoremap <silent> <Leader>w :write<CR>:source %<CR>

" Write a one-off version of the current buffer
nnoremap <Leader>t :write %:p:r_<C-r>=strftime('%Y%m%d')<CR>.%:e<CR>

" Source selection or current line
vnoremap <Leader>S y:execute @@<CR>:echomsg "Sourced selection"<CR>
nnoremap <Leader>S ^vg_y:execute @@<CR>:echomsg "Sourced current line"<CR>

" Remove trailing whitespace, merge consecutive empty lines
nnoremap <silent> <Leader>W :call <SID>NormalizeWhitespace()<CR>

" Re-indent entire buffer
nnoremap <silent> <Leader>= :call <SID>Preserve("normal! gg=G")<CR>

" sleuth.vim likes to change 'shiftwidth' to 8
nnoremap <Leader>4 :setlocal tabstop=4 softtabstop=4 shiftwidth=4<CR>

" Show highlighting groups for current word
nnoremap <silent> <Leader>p :call <SID>SynStack()<CR>

" Shortcuts for Fugitive plug-in
nnoremap <Leader>gg :Git<Space>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
vnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>g/ :Ggrep<Space>

" Git Gutter plug-in complements Fugitive
nnoremap <Leader>gu :GitGutterToggle<CR>
nnoremap <Leader>gh :GitGutterLineHighlightsToggle<CR>

" Shortcuts for Tabular plug-in
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>
nnoremap <Leader>aw :Tabularize multiple_spaces<CR>
vnoremap <Leader>aw :Tabularize multiple_spaces<CR>
nnoremap <Leader>ar :Tabularize rocket<CR>
vnoremap <Leader>ar :Tabularize rocket<CR>
nnoremap <Leader>as :Tabularize assignment<CR>
vnoremap <Leader>as :Tabularize assignment<CR>

" Shortcuts for delimitMate
nnoremap <Leader>dd :DelimitMateSwitch<CR>
nnoremap <Leader>dr :DelimitMateReload<CR>

" Traversing folds
nnoremap <C-k> zMzkzv[zzt
nnoremap <C-j> zMzjzvzt

" Switch to alternate window or buffer
nnoremap <silent> <Leader><Leader> :if winnr("$") > 1<Bar>wincmd p<Bar>else<Bar>buffer #<Bar>endif<CR>

nnoremap <Leader><CR> *<C-o>
map <BS> %

" Unimpaired.vim-like toggles
nnoremap [oo :set colorcolumn=+1<CR>
nnoremap ]oo :set colorcolumn=0<CR>
nnoremap coo :let &colorcolumn = ( &colorcolumn == "+1" ? "0" : "+1" )<CR>

" <Space> mappings for finding files
nnoremap <Space><Space> :CtrlP<CR>
nnoremap <Space>. :CtrlP .<CR>
nnoremap <Space>; :CtrlPBuffer<CR>
nnoremap <Space>~ :CtrlP $HOME<CR>
nnoremap <Space>, :CtrlPTag<CR>
nnoremap <Space>? :CtrlPMRU<CR>
nnoremap <Space>/ :vimgrep // **/*.<C-r>=expand("%:e")<CR>
  \ <Home><Right><Right><Right><Right><Right><Right><Right><Right><Right>
nnoremap <Space>G :edit $HOME/.dots/gvimrc<CR>
nnoremap <Space>L :edit $HOME/.vimrc.local<CR>
nnoremap <Space>M :edit Makefile<CR>
nnoremap <Space>N :edit $DOCS/vim.md<CR>
nnoremap <Space>R :edit Rakefile<CR>
nnoremap <Space>V :edit $HOME/.dots/vimrc<CR>
nnoremap <Space>bb :CtrlP $BLOG<CR>
nnoremap <Space>bd :CtrlP $BLOG/_drafts<CR>
nnoremap <Space>bp :CtrlP $BLOG/_posts<CR>
nnoremap <Space>c :CtrlP $HOME/.dots<CR>
nnoremap <Space>d :CtrlP $DOCS<CR>
nnoremap <Space>ka :CtrlP application<CR>
nnoremap <Space>kc :CtrlP application/classes/Controller<CR>
nnoremap <Space>ke :CtrlP application/messages<CR>
nnoremap <Space>kl :CtrlP application/logs<CR>
nnoremap <Space>km :CtrlP application/classes/Model<CR>
nnoremap <Space>ko :CtrlP application/config<CR>
nnoremap <Space>kt :CtrlP application/templates<CR>
nnoremap <Space>kv :CtrlP application/classes/View<CR>
nnoremap <Space>n :CtrlP $NOTES<CR>
nnoremap <Space>p :CtrlP $PROJECTS<CR>
nnoremap <Space>v :CtrlP $HOME/.vim<CR>

" }}}
" PLUG-INS                                                                     {{{
" --------------------------------------------------------------------------------

" :help ruby.vim
let g:ruby_fold = 1
let g:ruby_no_comment_fold = 1

" :help netrw-browser-options
let g:netrw_banner = 0

" :help menu.vim
let g:did_install_default_menus = 1
let g:did_install_syntax_menu = 1

" :help syntastic-global-options
if &termencoding ==# "utf-8" || &encoding ==# "utf-8"
  let g:syntastic_error_symbol = "\u203c"
  let g:syntastic_warning_symbol = "\u203c"
  let g:syntastic_style_error_symbol = "\u00a7"
  let g:syntastic_style_warning_symbol = "\u00a7"
endif

" :help syntastic-config-makeprg
" Don't complain about indentation with tabs, set encoding
let g:syntastic_php_phpcs_post_args = "--tab-width=4 --encoding=utf-8"
" Use PSR2 standard instead of default PEAR
" http://www.php-fig.org/psr/2/
let g:syntastic_php_phpcs_post_args .= " --standard=PSR2"

" xptemplate key
let g:xptemplate_key = "<Tab>"

" UltiSnips settings
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:UltiSnipsSnippetDir = "~/.vim/snippets"
let g:UltiSnipsSnippetDirectories = ["snippets"]

" Reverse Command-T match list so best result appears at bottom
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxHeight = 12

" CtrlP
let g:ctrlp_extensions = ['tag']

" delimitMate settings
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_balance_matchpairs = 1

" :help supertab-options
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1

" :help supertab-completionchaining
if has("autocmd")
  augroup SuperTabRC
    autocmd!
    autocmd FileType *
      \ if exists("*SuperTabChain") && &omnifunc != '' |
      \   call SuperTabChain(&omnifunc, "<C-p>") |
      \   call SuperTabSetDefaultCompletionType("<C-x><C-u>") |
      \ endif
  augroup END
endif

" }}}
" LOCAL VIMRC                                                                  {{{
" --------------------------------------------------------------------------------

" Local
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" }}}
" vim: fdm=marker:sw=2:sts=2:et
