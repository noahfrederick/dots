" Plug-ins                                                                     {{{
" --------------------------------------------------------------------------------

let s:user_runtime = split(&runtimepath, ',')[0]

if has('vim_starting')
  call plug#begin()

  " Use GitHub username unless local source dir is set
  let $PLUG_SRC = exists('$CODE') ? $CODE : 'noahfrederick'

  " General-purpose utilities
  call plug#('AndrewRadev/sideways.vim')
  call plug#('AndrewRadev/splitjoin.vim')
  call plug#('AndrewRadev/switch.vim', { 'on': 'Switch' })
  call plug#('SirVer/ultisnips', { 'on': ['UltiSnipsAddFiletypes', 'UltiSnipsEdit'] })
  call plug#('godlygeek/tabular', { 'on': 'Tabularize' })

  augroup init_tabular
    autocmd!
    autocmd User tabular call my#tabular#setup()
  augroup END

  call plug#('junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all --xdg', 'tag': '*' })
  call plug#('junegunn/gv.vim', { 'on': 'GV' })
  call plug#('justinmk/vim-dirvish')
  call plug#('machakann/vim-highlightedyank')
  call plug#('mhinz/vim-signify')
  call plug#('pgdouyon/vim-evanesco')
  call plug#('talek/obvious-resize', { 'on': ['ObviousResizeUp', 'ObviousResizeDown', 'ObviousResizeLeft', 'ObviousResizeRight'] })
  call plug#('tpope/vim-abolish')
  call plug#('tpope/vim-commentary', { 'on': ['<Plug>Commentary', '<Plug>CommentaryLine', '<Plug>ChangeCommentary'] })
  call plug#('tpope/vim-dispatch')
  call plug#('tpope/vim-endwise')
  call plug#('tpope/vim-eunuch')
  call plug#('tpope/vim-fugitive')
  call plug#('tpope/vim-obsession')
  call plug#('tpope/vim-projectionist')
  call plug#('tpope/vim-repeat')
  call plug#('tpope/vim-rhubarb')
  call plug#('tpope/vim-sleuth')
  call plug#('tpope/vim-speeddating')
  call plug#('tpope/vim-surround')
  call plug#('tpope/vim-unimpaired')
  call plug#('cohama/lexima.vim')
  call plug#('wellle/targets.vim')
  if has('mac')
    call plug#($PLUG_SRC.'/vim-codekit', { 'on': ['CKadd', 'CKfocus', 'CKpreview', 'CKpause', 'CKunpause'] })
    call plug#('rizzatti/dash.vim', { 'on': ['Dash', '<Plug>DashSearch', '<Plug>DashGlobalSearch'] })
  endif
  if has('nvim')
    call plug#('autozimu/LanguageClient-neovim', { 'branch': 'next', 'tag': '*', 'do': 'bash install.sh' })
    call plug#('roxma/LanguageServer-php-neovim', { 'do': 'composer install && composer run-script parse-stubs' })

    call plug#('roxma/nvim-yarp')
    call plug#('ncm2/ncm2')
    call plug#('ncm2/ncm2-bufword')
    call plug#('ncm2/ncm2-cssomni')
    call plug#('ncm2/ncm2-html-subscope')
    call plug#('ncm2/ncm2-markdown-subscope')
    call plug#('ncm2/ncm2-path')
    call plug#('ncm2/ncm2-tmux')
    call plug#('ncm2/ncm2-ultisnips')

    augroup init_ncm2
      autocmd!
      autocmd BufEnter * call ncm2#enable_for_buffer()
    augroup END
  else
    call plug#($PLUG_SRC.'/vim-neovim-defaults')
  endif

  " Text objects
  call plug#('adriaanzon/vim-textobj-blade-directive', { 'for': 'blade' })
  call plug#('akiyan/vim-textobj-php', { 'for': 'php' })
  call plug#('kana/vim-textobj-function')
  call plug#('kana/vim-textobj-user')
  call plug#('mattn/vim-textobj-url')
  call plug#('nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' })
  call plug#('whatyouhide/vim-textobj-xmlattr')

  " Language-/framework-specific utilities
  call plug#($PLUG_SRC.'/vim-composer')
  call plug#($PLUG_SRC.'/vim-jekyll')
  call plug#($PLUG_SRC.'/vim-kohana')
  call plug#($PLUG_SRC.'/vim-laravel')
  call plug#('ap/vim-css-color')
  call plug#('dbakker/vim-sparkup')
  call plug#('phpactor/phpactor', { 'for': 'php', 'do': 'composer install' })
  call plug#('tpope/vim-bundler')
  call plug#('tpope/vim-jdaddy', { 'for': 'json' })
  call plug#('tpope/vim-rake')
  call plug#('tpope/vim-rbenv')
  call plug#('tpope/vim-scriptease')

  " File-type runtime files
  call plug#('blueyed/smarty.vim')
  call plug#('kana/vim-vspec')
  call plug#('ledger/vim-ledger')
  call plug#('sheerun/vim-polyglot')

  call plug#end()

  " Load slow plug-ins when when needed.
  augroup init_slow_insert_mode_plugins
    autocmd!
    autocmd InsertEnter * call my#plug#load_insert_mode() |
          \ autocmd! init_slow_insert_mode_plugins
  augroup END
endif

" }}}
" General settings                                                             {{{
" --------------------------------------------------------------------------------

" Establish baseline settings, which may be overridden below
if !has("nvim") | runtime! plugin/neovim_defaults.vim | endif

"" Behavior
set spelllang=en_us             " Language and region to use for spellchecking
let &spellfile = join(map(['en', 'private'], {_, val -> s:user_runtime . '/spell/' . val . '.utf-8.add'}), ',')
set modeline modelines=2        " Look for modeline in first/last n lines of file
set hidden                      " Do not unload buffers when no longer displayed
set foldnestmax=3               " Limit depth of nested syntax/indent folds to n
set foldopen-=block             " Do not open folds on '(', '{', etc.
set foldtext=my#folding#text()
set switchbuf=useopen,usetab
set cpoptions-=_                " Make 'cw' behave like 'dw' etc.
set formatoptions+=r            " Insert comment leader after <Enter>
set formatoptions+=o            " Insert comment leader after o and O
if &shell =~# "fish$"
  set shell=/bin/bash           " Use a POSIX-compatible shell
endif

"" Display
set shortmess+=I                " Suppress intro message when starting Vim
set helpheight=1000             " Maximize help window vertically
set previewheight=20            " Preview window used for, e.g., :Gstatus
set linebreak                   " Wrap lines at word boundaries
if exists("+breakindent")
  set breakindent               " Indent soft-wrapped lines
endif
set signcolumn=yes              " Always show sign column to avoid margin jumping about

let &fillchars = "vert:\u2502,diff: "
let &listchars = "tab:\u25b8 ,extends:\u276f,precedes:\u276e,space:\u00b7,nbsp:\u2334,eol:\u00ac"
let &showbreak = "\u21aa "

augroup init_colorscheme
  autocmd!
  autocmd! ColorScheme * highlight VertSplit ctermbg=NONE guibg=NONE
augroup END

if has("vim_starting") && &t_Co >= 16
  silent! colorscheme noctu     " Set color scheme for 16-color+ terminals
endif

"" Clipboard
if has("unnamedplus")
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

"" Command line and completion
set wildmode=full               " 'wildchar' completes first match, no extra line of candidates shown
set wildcharm=<C-z>             " Trigger for completion in macros
set wildignore=*.swp,*.bak
set wildignore+=*.min.*,*.css.map
set wildignore+=*.jpg,*.png,*.gif,*.svg
set suffixes+=.css,.html        " Extensions that get a lower priority when matching wildcards
set completeopt=menuone         " Display menu when completing, even for only one candidate
set completeopt+=noselect       " Do not automatically select first item
set completeopt+=noinsert       " Do not automatically insert first item
set pumheight=8                 " Limit height of popup menu

if exists("+inccommand")        " Introduced in Nvim 0.1.7
  set inccommand=split          " Show live substitution in temporary split window
endif

"" Whitespace
set tabstop=4                   " Display width of tabs--indentation style is handled by sleuth.vim
set shiftround                  " Round indent to multiple of 'shiftwidth'
set nojoinspaces                " Do not insert two spaces after '.' when using J

"" Searching
set smartcase                   " Case-sensitivity triggered by capital letter if 'ignorecase' set

if executable('ag')
  set grepprg=ag\ --vimgrep
  "                 |
  "                 `------------ Format results for Vim, include multiple matches per line
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags
  "                  |||
  "                  ||`--------- Always print file names
  "                  |`---------- Print line numbers
  "                  `----------- Search directories recursively
endif

"" Status line
let &statusline  = ' %2*%{exists("*ObsessionStatus")?ObsessionStatus(StatuslineProject(), "[".StatuslineProject()."]"):""}'
let &statusline .= '%#StatusLineNC#%{exists("*ObsessionStatus")?ObsessionStatus("", "", StatuslineProject()):StatuslineProject()}'
let &statusline .= "%*%{empty(expand('%'))?'':expand('%')}"
let &statusline .= "%#StatusLineNC#%{StatuslineGit()}%* "
let &statusline .= '%1*%{&modified && !&readonly?"\u25cf ":""}%*'
let &statusline .= '%1*%{&modified && &readonly?"\u25cb ":""}%*'
let &statusline .= '%4*%{&modifiable?"":"\u25cb "}%*'
let &statusline .= '%3*%{&readonly && &modifiable && !&modified?"\u25cb ":""}%*'
let &statusline .= "%="
let &statusline .= "%#StatusLineNC#%{StatuslineIndent()}%* "
let &statusline .= '%#StatuslineNC#%{(strlen(&fileencoding) && &fileencoding !=# &encoding)?&fileencoding." ":""}'
let &statusline .= '%{&fileformat!="unix"?" ".&fileformat." ":""}%*'
let &statusline .= '%{strlen(&filetype)?&filetype." ":""}'
let &statusline .= '%#Error#%{exists("*neomake#statusline#QflistStatus")?neomake#statusline#QflistStatus().neomake#statusline#LoclistStatus():""}'
let &statusline .= "%{StatuslineTrailingWhitespace()}%*"

function! StatuslineGit()
  if !exists('*fugitive#head')
    return ''
  endif
  let l:out = fugitive#head(8)
  if !empty(l:out) && !empty(expand('%'))
    let l:out = '  @ ' . l:out
  elseif !empty(l:out)
    let l:out = ' ' . l:out
  endif
  return l:out
endfunction

function! StatuslineIndent()
  if !&modifiable || &buftype ==# 'terminal'
    return ''
  endif

  if &expandtab == 0 && &tabstop == 8
    " Sleuth.vim has detected mixed indentation
    return "!!"
  endif

  let l:symbol = &expandtab ? "\u2022" : "\u21e5 "
  let l:amount = exists('*shiftwidth') ? shiftwidth() : &shiftwidth
  return &expandtab ? repeat(l:symbol, l:amount) : l:symbol
endfunction

function! StatuslineProject()
  if empty(expand('%'))
    return ''
  endif
  let dir = getcwd() == $HOME ? '~' : fnamemodify(getcwd(), ':t')
  return dir . (expand('%')[0] !~# '\v[\[/]' && stridx(expand('%:p'), getcwd()) == 0 ? '/' : ' ')
endfunction

function! StatuslineTrailingWhitespace()
  if !exists("b:statusline_trailing_whitespace")
    if !&modifiable || search('\s\+$', 'nw') == 0
      let b:statusline_trailing_whitespace = ""
    else
      let b:statusline_trailing_whitespace = "  \u2334 "
    endif
  endif

  return b:statusline_trailing_whitespace
endfunction

augroup init_statusline
  autocmd!
  autocmd CursorHold,BufWritePost * unlet! b:statusline_trailing_whitespace
augroup END

"" Tab line
set tabline=%!Tabline()

function! Tabline() abort
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " Set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'
    let s .= ' %{TablineLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  return s
endfunction

function! TablineLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufname = bufname(buflist[winnr - 1])
  let title = empty(bufname) ? '-' : fnamemodify(bufname, ':t')
  return a:n . ' ' . title
endfunction

" }}}
" Autocommands                                                                 {{{
" --------------------------------------------------------------------------------

augroup init
  autocmd!

  autocmd User Composer
        \ nmap <buffer> <LocalLeader>f <Plug>(composer-find) |
        \ nmap <buffer> <LocalLeader>u <Plug>(composer-use)
  autocmd User Laravel call my#filetype#append('laravel')

  " Never show line numbers in command-line window as they are not useful
  " and take up space (normally it inherits this setting like any other
  " window)
  autocmd CmdwinEnter * set nonumber
  autocmd QuickFixCmdPost *grep* cwindow
  autocmd WinEnter * if &previewwindow | execute "setlocal statusline=" . repeat("\u2500", winwidth(0)) | endif
  autocmd FileType fzf execute "setlocal statusline=%2*" . repeat("\u2500", winwidth(0))
augroup END

augroup init_cursorline
  autocmd!

  " Only highlight cursor line in window with focus
  autocmd WinLeave * set nocursorline
  autocmd WinEnter *
        \ if &filetype !=# 'qf' && &buftype !=# 'terminal' && !&diff |
        \   set cursorline |
        \ endif
  if exists('##TermOpen')
    autocmd TermOpen * set nocursorline
    autocmd TermOpen * nnoremap <buffer> <CR> i<CR>
  endif
augroup END

augroup init_whitespace
  autocmd!

  highlight default link TrailingWhitespace ErrorMsg

  autocmd BufWinEnter * if &modifiable | match TrailingWhitespace /\s\+$/ | endif
  autocmd InsertEnter * if &modifiable | match TrailingWhitespace /\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &modifiable | match TrailingWhitespace /\s\+$/ | endif
  autocmd BufWinLeave * if &modifiable | silent! call matchdelete(1) | endif
  autocmd FileType GV silent! call matchdelete(1)
  autocmd FileType vim-plug silent! call matchdelete(1)
augroup END

augroup init_org
  autocmd!

  if exists('$NOTES') && filereadable($NOTES.'/.repos.json')
    let g:my#org#repos = json_decode(readfile($NOTES.'/.repos.json'))
  endif

  if exists('$NOTES') && filereadable($NOTES.'/.capture.json')
    let g:my#org#capture#templates = json_decode(readfile($NOTES.'/.capture.json'))
  endif

  autocmd BufReadCmd org://* nested call my#org#protocol#handle(expand('<afile>'))
augroup END

" }}}
" User-Defined Commands                                                        {{{
" --------------------------------------------------------------------------------

command! -bang -bar Bdelete call my#buffer#delete(<q-bang>)
command! -bang -nargs=? -complete=buffer Bufonly
      \ call my#buffer#only(<q-args>, <q-bang>)
command! -nargs=0 -bar FollowSymlink call my#path#follow_symlink()
command! -bang -nargs=? -bar -complete=filetype Scratch
      \ tabedit | if !empty(<q-bang>) | put | 1delete _ | endif |
      \ let &filetype = empty(<q-args>) ? 'markdown' : <q-args> |
      \ setlocal buftype=nofile bufhidden=hide noswapfile
command! -nargs=0 -bar Unix set fileformat=unix
command! -bang -nargs=0 -bar Cd cd<bang> .
command! -bang -nargs=0 -bar -count=8 Indent call my#editing#set_indent_style(<count>, <bang>0)
command! -bang -nargs=1 -bar -complete=help Help <mods> help<bang> <args> |
      \ let @* = printf('[`:help %s`](https://vimhelp.appspot.com/%s.html#%s)', escape(<q-args>, '`[]'), expand('%:t'), escape(<q-args>, '()'))

command! -bar -bang -nargs=? -complete=customlist,my#org#complete_repos
      \ Notes call my#org#fzf#notes(<q-args>, <bang>0)
command! -bar -bang -nargs=? -complete=customlist,my#org#complete_repos
      \ NoteGrep call my#org#fzf#grep(<q-args>, <bang>0)
command! -bar -bang -nargs=? -complete=customlist,my#org#capture#complete_templates -range
      \ Capture if empty(<q-args>) |
      \              call my#org#fzf#capture(<q-bang>) |
      \            elseif <bang>0 |
      \              call my#org#capture#it(<q-args>, {'edit_command': 'edit'}) |
      \            else |
      \              call my#org#capture#it(<q-args>) |
      \            endif
command! -bang -bar -nargs=0 ShoppingList call my#org#shopping#list(<bang>0)

" See the difference between the current buffer and the file it was loaded
" from, thus the changes you made.
command! DiffOrig vertical new | set buftype=nofile | read # | 0delete_
      \ | diffthis | wincmd p | diffthis

command! -nargs=0 -bar -bang               Zbuffers call my#fzf#buffers(<bang>0)
command! -nargs=? -bar -bang -complete=dir Zfiles   call my#fzf#files(<q-args>, <bang>0)
command! -nargs=0 -bar -bang               Ztags    call my#fzf#tags(<bang>0)
command! -nargs=0 -bar -bang               Zhelp    call my#fzf#helptags(<bang>0)
command! -nargs=0 -bar -bang               Zhistory call my#fzf#history(<bang>0)
command! -nargs=0 -bar -bang               Zlines   call my#fzf#lines(<bang>0)
command! -nargs=0 -bar -bang               Zblines  call my#fzf#blines(<bang>0)
command! -nargs=0 -bar -bang               Zmarks   call my#fzf#marks(<bang>0)
command! -nargs=* -bar -bang               Zgrep    call my#fzf#grep(<q-args>, <bang>0)
command! -nargs=0 -bar -bang               Zfixme   Zgrep<bang> (FIXME\|TODO\|XXX)

augroup init_fzf
  autocmd!
  autocmd User Laravel command! -buffer -nargs=0 -bar -bang Zartisan
        \ call my#fzf#artisan(<bang>0)
  autocmd User Laravel command! -buffer -nargs=0 -bar -bang Zuse
        \ call my#fzf#use(<bang>0)
  autocmd User Laravel nnoremap <buffer> <LocalLeader>A :Zartisan<CR>
  autocmd User Laravel nnoremap <buffer> <LocalLeader>U :Zuse<CR>
augroup END

if executable('osascript')
  command! -nargs=? -bang -bar -complete=file Transmit call my#transmit#send(<q-bang>, <q-args>)
endif

if exists(":terminal")
  command! -nargs=0 -bang -bar Shell -tabedit | terminal<bang> $SHELL
else
  command! -nargs=0 -bar Shell shell
endif

" }}}
" Mappings                                                                     {{{
" --------------------------------------------------------------------------------

let g:mapleader = "\<Space>"

" Try a custom command with fallback normal mode command
function! s:try(cmd, default)
  if exists(':' . a:cmd) && !v:count
    let tick = b:changedtick
    execute a:cmd
    if tick == b:changedtick
      execute join(['normal!', a:default])
    endif
  else
    execute join(['normal! ', v:count, a:default], '')
  endif
endfunction

" Try a custom command with fallback window command
function! s:try_wincmd(cmd, default)
  if exists(':' . a:cmd)
    let cmd = v:count ? join([a:cmd, v:count]) : a:cmd
    execute cmd
  else
    execute join([v:count, 'wincmd', a:default])
  endif
endfunction

" Flexibly define maps for SplitJoin with fallbacks
nnoremap <silent> J :<C-u>call <SID>try('SplitjoinJoin',  'J')<CR>
nnoremap <silent> S :<C-u>call <SID>try('SplitjoinSplit', "r\015")<CR>
nnoremap         gJ J
nnoremap         gS r<CR>

" The arrow keys are suitable for window resizing since it's not a common
" action and they can be mashed, unlike <C-w>+ etc.
nnoremap <silent>    <Up> :<C-u>call <SID>try_wincmd('ObviousResizeUp',    '+')<CR>
nnoremap <silent>  <Down> :<C-u>call <SID>try_wincmd('ObviousResizeDown',  '-')<CR>
nnoremap <silent>  <Left> :<C-u>call <SID>try_wincmd('ObviousResizeLeft',  '<')<CR>
nnoremap <silent> <Right> :<C-u>call <SID>try_wincmd('ObviousResizeRight', '>')<CR>

nnoremap <Leader><Leader> <C-w>p

nnoremap <silent> <CR> :<C-u>call <SID>try('Switch', "\015")<CR>

nnoremap <silent> <A-h> :call my#window#nav('h')<CR>
nnoremap <silent> <A-j> :call my#window#nav('j')<CR>
nnoremap <silent> <A-k> :call my#window#nav('k')<CR>
nnoremap <silent> <A-l> :call my#window#nav('l')<CR>

nnoremap <A-c> <C-w>c
nnoremap <A-w> <C-w>w

nnoremap <A-S-h> <C-w>H
nnoremap <A-S-j> <C-w>J
nnoremap <A-S-k> <C-w>K
nnoremap <A-S-l> <C-w>L

if exists(":tnoremap")
  tnoremap <silent> <A-h> <C-\><C-n>:call my#window#nav('h')<CR>
  tnoremap <silent> <A-j> <C-\><C-n>:call my#window#nav('j')<CR>
  tnoremap <silent> <A-k> <C-\><C-n>:call my#window#nav('k')<CR>
  tnoremap <silent> <A-l> <C-\><C-n>:call my#window#nav('l')<CR>

  tnoremap <A-c> <C-w>c
  tnoremap <A-w> <C-w>w

  tnoremap <A-S-h> <C-\><C-n><C-w>H
  tnoremap <A-S-j> <C-\><C-n><C-w>J
  tnoremap <A-S-k> <C-\><C-n><C-w>K
  tnoremap <A-S-l> <C-\><C-n><C-w>L
endif

" Make Y consistent with C and D
nnoremap Y y$

" Paste over a visual selection while preserving the unnamed register
xnoremap P "_dP

" Q repeats the last command-line command (Ex mode is still accessible via gQ)
nnoremap Q @:

" Linewise movement should work on screen lines
noremap k gk
noremap j gj
noremap gk k
noremap gj j

" Clear search highlighting and any message already displayed
nnoremap <silent> <C-l> :call my#display#refresh()<CR>

" Expand %% to directory of current file in command-line mode
cnoremap %% <C-r>=fnameescape(expand("%:~:h"))<CR>/

" Easier mapping to insert word under cursor when searching
cnoremap <expr> <Tab> getcmdtype() =~# '[/?]' ? "\<C-r>\<C-w>" : "\<C-z>"

" Use character under cursor as first character in digraph and replace it
" Ex.:
"   Pressing <Leader><C-k>- on the 'e' in
"     habere
"   Makes
"     habēre
nnoremap <expr> <Plug>NormalModeDigraph my#editing#normal_mode_digraph(nr2char(getchar()))
nmap <Leader><C-k> <Plug>NormalModeDigraph

" Look up documentation with Dash.app
function! s:doc(cmd)
  if &keywordprg =~? '^:\?man'
    return a:cmd
  endif
  return "K"
endfunction

nmap <expr> K  <SID>doc("\<Plug>DashSearch")
nmap <expr> gK <SID>doc("\<Plug>DashGlobalSearch")

" Remove the last character on current line:
" This is something I find myself doing often, but I find it difficult to hit
" '$' quickly. This has the added bonus of working on a range of lines and
" being repeatable.
noremap <silent> <Plug>RemoveLastCharacter :normal! $x<CR>
      \:silent! call repeat#set("\<Plug>RemoveLastCharacter")<CR>
nmap <Leader>x <Plug>RemoveLastCharacter
xmap <Leader>x <Plug>RemoveLastCharacter

" Swap single and double quotes
noremap <silent> <Plug>SwapQuotesN :<C-u>keeppatterns
      \ s/['"]/\="'\""[submatch(0)!='"']/ge<CR>
      \:silent! call repeat#set("\<Plug>SwapQuotesN")<CR>
noremap <silent> <Plug>SwapQuotesX :<C-u>keeppatterns
      \ '<,'>s/['"]/\="'\""[submatch(0)!='"']/ge<CR>
      \:silent! call repeat#set("\<Plug>SwapQuotesX")<CR>
nmap <Leader>' <Plug>SwapQuotesN
xmap <Leader>' <Plug>SwapQuotesX

" Shortcut for inserting date and time in various formats
" from @tpope. The repeat(..., 0) makes it such that there's
" no output from <C-r>=
inoremap <silent> <C-g><C-t> <C-r>=repeat(complete(col('.'), map([
      \ "%Y-%m-%d %H:%M:%S",
      \ "%Y-%m-%d",
      \ "%Y %b %d",
      \ "%d-%b-%y",
      \ "%a, %d %b %Y %H:%M:%S %z",
      \ "%a %b %d %T %Z %Y"
      \ ], 'strftime(v:val)')), 0)<CR>

" <C-y> and <C-e> insert to end of word instead of single characters
" (Note that this clobbers <C-y>'s function when the completion popup is
" visible--this is by design, as it is cumbersome in combination with
" autocompletion where the completion menu may show as you insert text.)
inoremap <expr> <C-y> matchstr(getline(line('.') - 1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <C-e> matchstr(getline(line('.') + 1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

nnoremap <silent> <F2> :if &previewwindow<Bar>pclose<Bar>elseif exists(':Gstatus')<Bar>Gstatus<Bar>endif<CR>
nnoremap <silent> <F3> :call my#quickfix#toggle('c')<CR>
nnoremap <silent> <F4> :call my#quickfix#toggle('l')<CR>

" :help dispatch-commands
nnoremap dm    :Make<CR>
nnoremap d<CR> :Dispatch<CR>
nnoremap du    :FocusDispatch<Space>
nnoremap dr    :Start<CR>
nnoremap dc    :Console<CR>

" Write a one-off timestamped version of the current buffer
nnoremap <Leader>T :write %:p:r_<C-r>=strftime('%Y%m%d-%H%M%S')<CR>.%:e<CR>

" Remove trailing whitespace, merge consecutive empty lines
nnoremap <silent> <Leader>w :call my#editing#normalize_whitespace()<CR>

" Re-indent entire buffer content
nnoremap <silent> <Leader>= :call my#editing#reindent_buffer()<CR>

" Yank entire buffer content
nnoremap <silent> <Leader>y :call my#editing#yank_buffer()<CR>

nnoremap <Leader>g<Space> :Git<Space>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit --verbose<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
xnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>g/ :Ggrep<Space>
nnoremap <Leader>gv :GV<CR>
xnoremap <Leader>gv :GV<CR>
nnoremap <Leader>gV :GV!<CR>

nnoremap gs :Shell<CR>

nnoremap <Leader>t :Transmit<CR>

" Traversing folds
nnoremap <C-k> zMzkzv[zzt
nnoremap <C-j> zMzjzvzt

" Force indentation style
nnoremap <Leader>1 :4Indent<CR>
nnoremap <Leader>2 :2Indent!<CR>
nnoremap <Leader>4 :4Indent!<CR>

" Switch to alternate window or buffer
nnoremap <silent> <Leader>6 :if winnr("$") > 1
      \ <Bar>wincmd p<Bar>else<Bar>buffer #<Bar>endif<CR>

nnoremap <Leader>8 :set hlsearch<CR>*<C-o>
nnoremap <Leader>/ :Zlines<CR>
map <BS> %

nnoremap <expr><silent> ZB ":<C-u>Bdelete" . (v:count ? "!" : "") . "<CR>"

" Unimpaired.vim-like toggles
nnoremap <silent> [oo :let &colorcolumn = '+' . join(range(1, 250), ',+')<CR>
nnoremap <silent> ]oo :set colorcolumn=0<CR>
nnoremap <silent> yoo :let &colorcolumn = (&colorcolumn == '0' ? '+' . join(range(1, 250), ',+') : '0')<CR>

" Undo https://github.com/tpope/vim-unimpaired/commit/3a7759075cca5b0dc29ce81f2747489b6c8e36a7
" and subsequent change to yo
nmap co yo

nnoremap [<Tab> :SidewaysLeft<CR>
nnoremap ]<Tab> :SidewaysRight<CR>

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

nnoremap <Leader>a= :Tabularize /=<CR>
xnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize colon<CR>
xnoremap <Leader>a: :Tabularize colon<CR>
nnoremap <Leader>a, :Tabularize comma<CR>
xnoremap <Leader>a, :Tabularize comma<CR>
nnoremap <Leader>a<Bar> :Tabularize table<CR>
xnoremap <Leader>a<Bar> :Tabularize table<CR>
nnoremap <Leader>aa :Tabularize /
xnoremap <Leader>aa :Tabularize /
nnoremap <Leader>aw :Tabularize multiple_spaces<CR>
xnoremap <Leader>aw :Tabularize multiple_spaces<CR>
nnoremap <Leader>ar :Tabularize rocket<CR>
xnoremap <Leader>ar :Tabularize rocket<CR>
nnoremap <Leader>as :Tabularize assignment<CR>
xnoremap <Leader>as :Tabularize assignment<CR>

" Commentary maps, since it is loaded lazily
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>Commentary

" Force a file type
nnoremap _cs :set filetype=css<CR>
nnoremap _er :set filetype=eruby<CR>
nnoremap _ht :set filetype=html<CR>
nnoremap _js :set filetype=javascript<CR>
nnoremap _md :set filetype=markdown<CR>
nnoremap _ph :set filetype=php<CR>
nnoremap _py :set filetype=python<CR>
nnoremap _rb :set filetype=ruby<CR>
nnoremap _sh :set filetype=sh<CR>
nnoremap _tx :set filetype=text<CR>
nnoremap _vi :set filetype=vim<CR>
nnoremap _xm :set filetype=xml<CR>

" <Leader> mappings for navigating files and buffers
nnoremap <Leader>? :Zhistory<CR>
nnoremap <Leader>` :Zmarks<CR>
nnoremap <Leader>] :Ztags<CR>
nnoremap <Leader>D :edit README*<CR>
nnoremap <Leader>E :edit Gemfile<CR>
nnoremap <Leader>H :edit .htaccess<CR>
nnoremap <Leader>I :edit .gitignore<CR>
nnoremap <Leader>K :Bufonly<CR>
nnoremap <Leader>M :edit Makefile<CR>
nnoremap <Leader>R :edit Rakefile<CR>
nnoremap <Leader>U :edit Guardfile<CR>
if has('nvim')
  nnoremap <Leader>X :edit .nvimrc<CR>
else
  nnoremap <Leader>X :edit .vimrc<CR>
endif
nnoremap <Leader>b :Zbuffers<CR>
nnoremap <Leader>d :Zfiles $CODE/dots<CR>
nnoremap <Leader>e :Zfiles <C-r>=expand('%:h')<CR><CR>
nnoremap <Leader>f :Zfiles<CR>
nnoremap <Leader>h :Zhelp<CR>
nnoremap <Leader>s :Scratch<CR>

nnoremap <Leader>n  :Notes<CR>
nnoremap <Leader>c  :Capture<CR>
xnoremap <Leader>c  :Capture<Space>

" }}}
" Plug-in Settings                                                             {{{
" --------------------------------------------------------------------------------

let g:UltiSnipsListSnippets = "<C-g><Tab>"
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Right>"
let g:UltiSnipsJumpBackwardTrigger = "<Left>"
let g:UltiSnipsSnippetsDir = s:user_runtime . '/snips'
let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir]

augroup init_ultisnips
  autocmd!
  autocmd BufNewFile * silent! call my#snippet#insert_skeleton()
  autocmd BufEnter * execute 'inoremap <silent> '
        \ . g:UltiSnipsExpandTrigger
        \ . ' <C-r>=my#snippet#expand_snippet_or_complete_maybe()<CR>'
augroup END

let g:LanguageClient_diagnosticsList = 'Location'

let g:signify_vcs_list = ['git']
let s:signify_sign = "\u2502"
let g:signify_sign_add               = s:signify_sign
let g:signify_sign_delete            = s:signify_sign
let g:signify_sign_delete_first_line = s:signify_sign
let g:signify_sign_change            = s:signify_sign
let g:signify_sign_changedelete      = s:signify_sign

" Disable splitjoin.vim maps (we define our own above)
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

let g:switch_mapping = ''

" Default of 'a' conflicts with Sideways argument text objects mapped above
let g:targets_argTrigger = 'A'

let g:projectionist_heuristics = {
      \   "script/console": {
      \     "*": {"console": "script/console"},
      \   },
      \   "script/server": {
      \     "*": {"start": "script/server"},
      \   },
      \   "script/test": {
      \     "*": {"dispatch": "script/test"},
      \   },
      \   "wordpress/|wp-config.php|style.css&header.php": {
      \     "*": { "framework": "wordpress" },
      \     "style.css": {
      \       "type": "style",
      \       "skeleton": "wordpress_theme_style",
      \     },
      \   },
      \   "gulpfile.js": {
      \     "*.css": {
      \       "dispatch": "gulp",
      \       "start": "gulp watch",
      \     },
      \     "*.less": {
      \       "dispatch": "gulp",
      \       "start": "gulp watch",
      \     },
      \     "*.js": {
      \       "dispatch": "gulp",
      \       "start": "gulp watch",
      \     },
      \   },
      \   "addon-info.json": {
      \     "*":              {"dispatch": ":Runtime ./{open}autoload,plugin{close}/**/*.vim"},
      \     "plugin/*.vim":   {"type": "plugin", "alternate": "doc/{}.vim"},
      \     "autoload/*.vim": {"type": "autoload", "alternate": "t/{}.vim"},
      \     "compiler/*.vim": {"type": "compiler"},
      \     "ftdetect/*.vim": {"type": "ftdetect"},
      \     "syntax/*.vim":   {"type": "syntax", "alternate": ["ftplugin/{}.vim", "indent/{}.vim"]},
      \     "ftplugin/*.vim": {"type": "ftplugin", "alternate": ["indent/{}.vim", "syntax/{}.vim"]},
      \     "indent/*.vim":   {"type": "indent", "alternate": ["syntax/{}.vim", "ftplugin/{}.vim"]},
      \     "after/*.vim":    {"type": "after"},
      \     "t/*.vim":        {"type": "test", "alternate": "autoload/{}.vim"},
      \     "doc/*.txt":      {"type": "doc"},
      \     "README.md":      {"type": "doc"},
      \   },
      \ }

" Sparkup shadows the very useful <C-e> as well as <C-n>/<C-p>
let g:sparkupDoMaps = 0

let g:ledger_fold_blanks = 1

let g:vim_markdown_frontmatter = 1

" Specify syntaxes to import for Markdown code blocks
let g:markdown_fenced_languages = ["sh", "vim", "ruby"]

let g:jekyll_dispatch = 'rake build'
let g:jekyll_start = 'rake serve'

" Neomake
let g:neomake_error_sign = {'text': "\u276f"}
let g:neomake_warning_sign = {'text': "\u276f"}

" Prevent csv.vim from setting its own 'foldtext'
let g:csv_disable_fdt = 1

" :help ruby.vim
let g:ruby_no_comment_fold = 1

let g:plug_window = '-tabnew'
let g:plug_pwindow = 'belowright vsplit'

" :help menu.vim
let g:did_install_default_menus = 1
let g:did_install_syntax_menu = 1

let g:loaded_netrwPlugin = 1

let g:terminal_color_0 = '#090e12'
let g:terminal_color_1 = '#ff2b68'
let g:terminal_color_2 = '#beda3f'
let g:terminal_color_3 = '#bcaa85'
let g:terminal_color_4 = '#78c9e9'
let g:terminal_color_5 = '#b88eec'
let g:terminal_color_6 = '#68a9af'
let g:terminal_color_7 = '#f1f1f1'
let g:terminal_color_8 = '#536B87'
let g:terminal_color_9 = '#e07689'
let g:terminal_color_10 = '#c5fcb8'
let g:terminal_color_11 = '#ddd4c1'
let g:terminal_color_12 = '#addbeb'
let g:terminal_color_13 = '#ebd0ea'
let g:terminal_color_14 = '#c2e6eb'
let g:terminal_color_15 = '#ffffff'

" }}}
" Local vimrc                                                                  {{{
" --------------------------------------------------------------------------------

" Include a local configuration file if available. It is sourced at the end so
" that any local settings override those in this file.
let s:local = s:user_runtime . '/local.vim'
if filereadable(s:local) | execute 'source' s:local | endif

" }}}
" vim: fdm=marker:sw=2:sts=2:et
