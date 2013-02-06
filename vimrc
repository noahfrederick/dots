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
if has("syntax")
  syntax enable                 " Enable syntax highlighting
endif

set encoding=utf-8              " Use UTF-8 as default file encoding
set shortmess+=I                " Suppress intro message when starting Vim
set laststatus=2                " Always show status line
set pastetoggle=<F2>            " Toggle paste mode (disables auto-indent etc.)
set modeline modelines=5        " Look for modeline at beginning/end of file
set autoread                    " Reload unchanged buffer when file changes
set history=500                 " Keep 500 lines of history
set hidden                      " Allow unwritten buffers to be hidden
set scrolloff=1                 " Keep a line above/below cursor visible
set sidescrolloff=5             " Keep 5 columns left/right of cursor visible
set fillchars=vert:\            " Use space for vertical split fill char
set listchars=tab:>\ ,eol:$,trail:~,extends:>,precedes:<,nbsp:+
if &termencoding ==# "utf-8" || &encoding ==# "utf-8"
  set listchars=tab:▸\ ,eol:¬,trail:·,extends:▷,precedes:◁,nbsp:+
endif
if has("linebreak")             " Wrap lines at word boundries
  set linebreak
  set showbreak=...
endif

"" Command line
set wildmenu                    " Command line completion
set cmdheight=2                 " Reserve two lines for command area

"" Whitespace
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set tabstop=4                   " Tabs count for 4 spaces
set shiftwidth=4                " Each indent step is 4 spaces

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

" In many terminal emulators the mouse works just fine, thus enable it.
if has("mouse")
  set mouse=a
endif

" Set color scheme for 16-color+ terminals
if &t_Co >= 16 || has("gui_running")
  silent! colorscheme noctu
endif

" Load matchit.vim, if a newer version isn't already installed
if !exists("g:loaded_matchit") && findfile("plugin/matchit.vim", &rtp) ==# ""
  runtime! macros/matchit.vim
endif

" }}}
" FUNCTIONS & COMMANDS                                                         {{{
" --------------------------------------------------------------------------------

" Set the appearance of the status line for various modes and states
function! <SID>SetStatusLine(mode)
  if &ft == "nerdtree"	" NERDTree sets its own minimal statusline
    return
  endif

  if a:mode == "normal"
    let histyle = "%3*"
  elseif a:mode == "insert"
    let histyle = "%2*"
  else
    let histyle = ""	" inactive
  endif

  " Get Git info from vim-fugitive for current buffer (if available)
  let mygit = exists("*fugitive#statusline") ? fugitive#statusline()[4:-2] : ""

  " Left side
  let mystl = histyle
  let mystl .= " %6.(#%n%)  %* %t%#StatusLineNC# ".mygit."%m%="

  " Right side
  let mystl .= "%{(&fenc==''?&enc:&fenc)}%* %{strlen(&ft)?&ft:'n/a'} "
  let mystl .= histyle
  let mystl .= " %3.l:%-3.c "

  let &l:statusline = mystl
endfunction

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
  " Read file again to trigger any plugins that are context-sensitive
  edit
endfunction

if !exists(":FollowSymlink")
  command FollowSymlink call <SID>FollowSymlink()
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
  augroup FileTypes
    autocmd!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
    autocmd FileType markdown setlocal textwidth=78
    if exists("&colorcolumn")
      autocmd Filetype text setlocal colorcolumn=+1
      autocmd Filetype markdown setlocal colorcolumn=+1
    endif

    " Always use spelling for particular file types
    autocmd FileType gitcommit setlocal spell

    " Use 2-space indents for Ruby
    autocmd FileType ruby setlocal softtabstop=2 shiftwidth=2 expandtab

    " Use 2-space indents for YAML
    autocmd FileType yaml setlocal softtabstop=2 shiftwidth=2 expandtab

    " Use 2-space indents for Vimscript
    autocmd FileType vim setlocal softtabstop=2 shiftwidth=2 expandtab

    " Use :make to check PHP syntax
    autocmd FileType php setlocal makeprg=php\ -l\ %
          \ errorformat=%m\ in\ %f\ on\ line\ %l

    " Set the filetype for common Ruby files not ending in .rb
    autocmd BufRead,BufNewFile {Gemfile,Rakefile} set filetype=ruby
  augroup END

  augroup StatusLineHighlight
    autocmd!

    " Set statusline for various modes and states
    autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,CursorHold,BufWritePost,InsertLeave *
          \ call <SID>SetStatusLine("normal")
    autocmd BufLeave,BufWinLeave,WinLeave,CmdwinLeave *
          \ call <SID>SetStatusLine("inactive")
    autocmd InsertEnter,CursorHoldI *
          \ call <SID>SetStatusLine("insert")
  augroup END
endif

" }}}
" MAPPINGS                                                                     {{{
" --------------------------------------------------------------------------------

" Make Y consistent with C and D
nnoremap Y y$

" Turn off highlighting and clear any message already displayed
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Expand %% to directory of current file in command-line mode
cnoremap %% <C-r>=expand("%:h")."/"<CR>

" Convenient ways to open files relative to current buffer
nnoremap <Leader>ew :e %%
nnoremap <Leader>es :sp %%
nnoremap <Leader>ev :vsp %%
nnoremap <Leader>et :tabe %%
nnoremap <Leader>el :FollowSymlink<CR>

" Toggle light/dark background
nnoremap <Leader>k :let &background = ( &background == "dark" ? "light" : "dark" )<CR>

" Make current file and show results in quickfix window
nnoremap <Leader>m :w<CR>:!clear<CR>:silent make %<CR>:cc<CR>

" Write buffer and source current file
nnoremap <silent> <Leader>w :w<CR>:so %<CR>

" Show highlighting groups for current word
nnoremap <silent> <Leader>p :call <SID>SynStack()<CR>

" Shortcuts for Fugitive plug-in
nnoremap <Leader>gg :Git 
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
vnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gm :Gmove 

" Shortcuts for Tabular plug-in
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize /:\zs<CR>
vnoremap <Leader>a: :Tabularize /:\zs<CR>
nnoremap <Leader>aw :Tabularize multiple_spaces<CR>
vnoremap <Leader>aw :Tabularize multiple_spaces<CR>

" NOTE: Command-T plug-in sets the following mappings:
"    nnoremap <silent> <Leader>t :CommandT<CR>
"    nnoremap <silent> <Leader>b :CommandTBuffer<CR>

" }}}
" PLUG-INS                                                                     {{{
" --------------------------------------------------------------------------------

" Settings for bundled PHP plug-in
let php_noShortTags = 1         " Always use <?php
let php_folding = 1             " Enable folding of classes/functions

" xptemplate key
let g:xptemplate_key = "<Tab>"

" Reverse Command-T match list so best result appears at bottom
let g:CommandTMatchWindowReverse = 1

" }}}
" LOCAL VIMRC                                                                  {{{
" --------------------------------------------------------------------------------

" Local
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" }}}

" vim: fdm=marker:sw=2:sts=2:et
