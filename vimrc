" --------------------------------------------------------------------------------
" GENERAL SETTINGS
" --------------------------------------------------------------------------------

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Use UTF-8 encoding
set encoding=utf-8

" Always show line numbers
set number

" Highlight current line
set cursorline

" Make status line always visible
set laststatus=2
set fillchars=vert:\ 
set cmdheight=2
set wildmenu

" Toggle paste mode, which will disable things including auto-indent when you
" want to paste text
set pastetoggle=<F2>

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set tabstop=4
set shiftwidth=4

set modeline modelines=20

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
" Don't store swaps in . -- store in ~/.vim/tmp/%path%to%orig.swp
set directory=~/.vim/tmp//,.,/var/tmp
" Don't store backups in . -- store in ~/.vim/tmp/%path%to%orig~
set backupdir=~/.vim/tmp//,.,/var/tmp

set incsearch		" do incremental searching
set ignorecase		" searches are case-insensitive...
set smartcase		" ...unless they contain at least one capital letter
set listchars=tab:▸\ ,eol:¬,trail:·

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif


" --------------------------------------------------------------------------------
" PATHOGEN
" --------------------------------------------------------------------------------

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" --------------------------------------------------------------------------------
" FILE TYPE SETTINGS
" --------------------------------------------------------------------------------

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

augroup FileTypes
	autocmd!

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78

	" Always use spelling for particular file types
	autocmd FileType gitcommit setlocal spell

	" Only highlight cursor line in active buffer window
	au WinLeave * set nocursorline
	au WinEnter * set cursorline
augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif


" --------------------------------------------------------------------------------
" SYNTAX & COLORS
" --------------------------------------------------------------------------------

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
	colorscheme noctu
endif


" --------------------------------------------------------------------------------
" STATUSLINE
" --------------------------------------------------------------------------------

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
	
	" Left side
	let mystl = histyle
	let mystl .= " %6.(#%n%)  %* %t%#StatusLineNC# %{fugitive#statusline()[4:-2]}%m%="

	" Right side
	let mystl .= "%{(&fenc==''?&enc:&fenc)}%* %{strlen(&ft)?&ft:'n/a'} "
	let mystl .= histyle
	let mystl .= " %3.l:%-3.c "

	let &l:statusline = mystl
endfunc

augroup StatusLineHighlight
	autocmd!
	au BufEnter,BufWinEnter,WinEnter,CmdwinEnter,CursorHold,BufWritePost,InsertLeave *
		\ call <SID>SetStatusLine("normal")
	au BufLeave,BufWinLeave,WinLeave,CmdwinLeave *
		\ call <SID>SetStatusLine("inactive")
	au InsertEnter,CursorHoldI *
		\ call <SID>SetStatusLine("insert")
augroup END


" --------------------------------------------------------------------------------
" MAPPINGS
" --------------------------------------------------------------------------------

" Disable arrow keys (training)
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Toggle light/dark background
nmap <Leader>b :let &background = ( &background == "dark" ? "light" : "dark" )<CR>

" Write buffer and source current file (useful when editing and testing config
" files
nmap <Leader>w :w<CR>:so %<CR>

nmap <Leader>t :NERDTreeToggle<CR>

" Show highlighting groups for current word
nmap <Leader>p :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Press Space to turn off highlighting and clear any message already
" displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Use ; instead of :
nnoremap ; :

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

