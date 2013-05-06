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

set encoding=utf-8              " Use UTF-8 as default file encoding
set spelllang=en_us             " Language and region to use for spellchecking
set shortmess+=I                " Suppress intro message when starting Vim
set laststatus=2                " Always show status line
set modeline modelines=5        " Look for modeline at beginning/end of file
set autoread                    " Reload unchanged buffer when file changes
set history=500                 " Keep 500 lines of history
set scrolloff=2                 " Keep lines above/below cursor visible
set sidescrolloff=5             " Keep columns left/right of cursor visible
set helpheight=1000             " Maximize help window vertically
set fillchars=vert:\            " Use space for vertical split fill char
if has("linebreak")             " Wrap lines at word boundaries
  set linebreak
  set showbreak=...
endif
set listchars=tab:>\ ,eol:$,trail:~,extends:>,precedes:<,nbsp:+
if &termencoding ==# "utf-8" || &encoding ==# "utf-8"
  let &fillchars = "vert:\u2502" | hi! VertSplit ctermbg=NONE
  let &listchars = "tab:\u25b8 ,eol:\u00ac,trail:\u2334,extends:\u276f,precedes:\u276e,nbsp:+"
  if has("linebreak")
    let &showbreak = "\u21aa"
  endif
endif

if has("unnamedplus")
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

"" Command line
set wildmenu                    " Command line completion
set cmdheight=2                 " Reserve two lines for command area

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
set ignorecase                  " Searches are case-insensitive...
set smartcase                   " ...unless they contain at least one capital letter
set gdefault                    " 'g' flag of ':substitute' is on by default

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
  exec "file ".fname
  " Read file again to trigger any plug-ins that are context-sensitive
  edit
endfunction

if !exists(":FollowSymlink")
  command FollowSymlink call <SID>FollowSymlink()
endif

function! <SID>NewPost(args)
  let g:template_title = a:args
  let file = "$BLOG/_posts/" . strftime("%Y-%m-%d") . "-" . tolower(substitute(a:args, " ", "-", "g")) . ".md"
  exec "e!" . file
endfunction

if !exists(":NewPost")
  command -nargs=1 NewPost call <SID>NewPost("<args>")
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" }}}
" AUTOCOMMANDS                                                                 {{{
" --------------------------------------------------------------------------------

if has("autocmd")
  augroup FileTypeOptions
    autocmd!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
    autocmd FileType markdown setlocal textwidth=78 | silent! compiler pandoc

    " Always use spelling for particular file types
    autocmd FileType gitcommit setlocal spell

    " Use :make to check PHP syntax
    autocmd FileType php setlocal makeprg=php\ -l\ %
          \ errorformat=%m\ in\ %f\ on\ line\ %l

    " Append semicolon or comma to end of line in insert mode
    autocmd FileType c,cpp,css,javascript,php inoremap <buffer> ;; <Esc>A;
    autocmd FileType c,cpp,css,javascript,php inoremap <buffer> ,, <Esc>A,

    " Automatically complete closing tags
    autocmd FileType html,liquid,markdown,php,xml inoremap <buffer> </ </<C-x><C-o>

    " Do not wrap lines in the QuickFix window
    autocmd FileType qf setlocal nowrap

    " Set the file type for common Ruby files not ending in .rb
    autocmd BufRead,BufNewFile {Gemfile,Rakefile} set filetype=ruby
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
noremap <Left> <C-w>>
noremap <Right> <C-w><

" Turn off highlighting and clear any message already displayed
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Expand %% to directory of current file in command-line mode
cnoremap %% <C-r>=expand("%:h")."/"<CR>

" Convenient ways to open files relative to current buffer
map <Leader>ew :e %%
map <Leader>es :sp %%
map <Leader>ev :vsp %%
map <Leader>et :tabe %%

" Toggle light/dark background
nnoremap <Leader>k :let &background = ( &background == "dark" ? "light" : "dark" )<CR>

" Make
nnoremap <Leader>mm :w<CR>:silent make<CR>:cc<CR>
nnoremap <Leader>md :Dispatch<CR>

" Write buffer and source current file
nnoremap <silent> <Leader>w :w<CR>:so %<CR>

" Source selection or current line
vnoremap <Leader>S y:execute @@<CR>:echomsg "Sourced selection."<CR>
nnoremap <Leader>S ^vg_y:execute @@<CR>:echomsg "Sourced current line."<CR>

" Clean trailing whitespace
nnoremap <Leader>W mz:%s/\s\+$//<CR>:let @/=""<CR>`z

" Re-indent entire buffer
nnoremap <Leader>= mzgg=G`z

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

" Shortcuts for delimitMate
nnoremap <Leader>dd :DelimitMateSwitch<CR>
nnoremap <Leader>dr :DelimitMateReload<CR>

" Traversing folds
nnoremap <C-k> zMzkzv[zzt
nnoremap <C-j> zMzjzvzt

nnoremap <Leader><CR> *<C-o>
noremap <BS> %

" Unimpaired.vim-like toggles
nnoremap [oo :set colorcolumn=+1<CR>
nnoremap ]oo :set colorcolumn=0<CR>
nnoremap coo :let &colorcolumn = ( &colorcolumn == "+1" ? "0" : "+1" )<CR>

" <Space> mappings for finding files
nnoremap <Space><Space> :CtrlPBuffer<CR>
nnoremap <Space>/ :CtrlP<CR>
nnoremap <Space>. :CtrlP .<CR>
nnoremap <Space>~ :CtrlP $HOME<CR>
nnoremap <Space>, :CtrlPTag<CR>
nnoremap <Space>? :CtrlPMRU<CR>
nnoremap <Space>G :e $HOME/.gvimrc<CR>
nnoremap <Space>L :e $HOME/.vimrc.local<CR>
nnoremap <Space>M :e Makefile<CR>
nnoremap <Space>N :e $DOCS/vim.md<CR>
nnoremap <Space>R :e Rakefile<CR>
nnoremap <Space>V :e $MYVIMRC<CR>
nnoremap <Space>bb :CtrlP $BLOG<CR>
nnoremap <Space>bg :!cd $BLOG && rake build && cd -<CR>
nnoremap <Space>bn :NewPost<Space>
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
nnoremap <Space>wn :CtrlP $WEBSITES/noahfrederick.com<CR>
nnoremap <Space>ww :CtrlP $WEBSITES<CR>

" }}}
" PLUG-INS                                                                     {{{
" --------------------------------------------------------------------------------

" Settings for bundled PHP plug-in
let php_noShortTags = 1         " Always use <?php

" xptemplate key
let g:xptemplate_key = "<Tab>"

" Reverse Command-T match list so best result appears at bottom
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxHeight = 12

" CtrlP
let g:ctrlp_extensions = ['tag']

" delimitMate settings
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_balance_matchpairs = 1

" }}}
" LOCAL VIMRC                                                                  {{{
" --------------------------------------------------------------------------------

" Local
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" }}}

" vim: fdm=marker:sw=2:sts=2:et
