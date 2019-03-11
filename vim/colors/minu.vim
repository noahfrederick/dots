" minu.vim - Vim color scheme
"
" This is a generated file. See colorscheme.rb.

" Setup {{{
highlight! clear

if exists('g:syntax_on')
  syntax reset
endif

let g:colors_name = 'minu'

"}}}
" Vim UI {{{
highlight Normal guifg=#eeeeee ctermfg=NONE guibg=#0e191b ctermbg=NONE gui=NONE cterm=NONE
highlight Cursor guifg=#eeeeee ctermfg=7 guibg=#ff2b68 ctermbg=1 gui=NONE cterm=NONE
highlight CursorLine guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight MatchParen guifg=#090e12 ctermfg=0 guibg=#b88eec ctermbg=5 gui=NONE cterm=NONE
highlight Pmenu guifg=#ffffff ctermfg=15 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight PmenuThumb guibg=#eeeeee ctermbg=7 gui=NONE cterm=NONE
highlight PmenuSBar guibg=#5c7897 ctermbg=8 gui=NONE cterm=NONE
highlight PmenuSel guifg=#090e12 ctermfg=0 guibg=#78c9e9 ctermbg=4 gui=NONE cterm=NONE
highlight ColorColumn guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight EndOfBuffer guifg=#090e12 ctermfg=0 gui=NONE cterm=NONE
highlight SpellBad guifg=#fdc2bd ctermfg=9 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight SpellCap guifg=#c5fcb8 ctermfg=10 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight SpellRare guifg=#ddd4c1 ctermfg=11 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight SpellLocal guifg=#ebd0ea ctermfg=13 guibg=NONE ctermbg=NONE gui=underline cterm=underline
highlight NonText guifg=#5c7897 ctermfg=8 gui=NONE cterm=NONE
highlight LineNr guifg=#5c7897 ctermfg=8 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight CursorLineNr guifg=#ddd4c1 ctermfg=11 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight Visual guifg=#090e12 ctermfg=0 guibg=#addbeb ctermbg=12 gui=NONE cterm=NONE
highlight IncSearch guifg=#090e12 ctermfg=0 guibg=#ebd0ea ctermbg=13 gui=NONE cterm=NONE
highlight Search guifg=#090e12 ctermfg=0 guibg=#c5fcb8 ctermbg=10 gui=NONE cterm=NONE
highlight StatusLine guifg=#eeeeee ctermfg=7 guibg=#090e12 ctermbg=0 gui=bold cterm=bold
highlight StatusLineNC guifg=#5c7897 ctermfg=8 guibg=#090e12 ctermbg=0 gui=bold cterm=bold
highlight VertSplit guifg=#090e12 ctermfg=0 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight TabLine guifg=#5c7897 ctermfg=8 guibg=#090e12 ctermbg=0 gui=bold cterm=bold
highlight TabLineSel guifg=#090e12 ctermfg=0 guibg=#eeeeee ctermbg=7 gui=bold cterm=bold
highlight Folded guifg=#5c7897 ctermfg=8 guibg=#090e12 ctermbg=0 gui=bold cterm=bold
highlight Conceal guifg=#68a9af ctermfg=6 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight Directory guifg=#addbeb ctermfg=12 gui=NONE cterm=NONE
highlight Title guifg=#bcaa85 ctermfg=3 gui=bold cterm=bold
highlight ErrorMsg guifg=#ffffff ctermfg=15 guibg=#ff2b68 ctermbg=1 gui=NONE cterm=NONE
highlight WarningMsg guifg=#ffffff ctermfg=15 guibg=#bcaa85 ctermbg=3 gui=NONE cterm=NONE
highlight DiffAdd guifg=#090e12 ctermfg=0 guibg=#beda3f ctermbg=2 gui=NONE cterm=NONE
highlight DiffChange guifg=#090e12 ctermfg=0 guibg=#bcaa85 ctermbg=3 gui=NONE cterm=NONE
highlight DiffDelete guifg=#090e12 ctermfg=0 guibg=#ff2b68 ctermbg=1 gui=NONE cterm=NONE
highlight DiffText guifg=#090e12 ctermfg=0 guibg=#ddd4c1 ctermbg=11 gui=bold cterm=bold
highlight User1 guifg=#ff2b68 ctermfg=1 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User2 guifg=#78c9e9 ctermfg=4 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User3 guifg=#beda3f ctermfg=2 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User4 guifg=#bcaa85 ctermfg=3 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User5 guifg=#b88eec ctermfg=5 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User6 guifg=#68a9af ctermfg=6 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User7 guifg=#eeeeee ctermfg=7 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User8 guifg=#5c7897 ctermfg=8 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User9 guifg=#ffffff ctermfg=15 guibg=#b88eec ctermbg=5 gui=NONE cterm=NONE
highlight! link CursorColumn CursorLine
highlight! link SignColumn LineNr
highlight! link WildMenu Visual
highlight! link FoldColumn SignColumn
highlight! link MoreMsg Title
highlight! link Question MoreMsg
highlight! link ModeMsg NonText
highlight! link TabLineFill StatusLineNC
highlight! link SpecialKey NonText

"}}}
" Generic Syntax {{{
highlight Comment guifg=#5c7897 ctermfg=8 gui=italic cterm=italic
highlight Keyword guifg=#eeeeee ctermfg=7 gui=bold cterm=bold
highlight Todo guifg=#ffffff ctermfg=15 guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline
highlight Function guifg=#eeeeee ctermfg=7 gui=italic cterm=italic
highlight Constant guifg=#78c9e9 ctermfg=4 gui=NONE cterm=NONE
highlight Special guifg=#ebd0ea ctermfg=13 gui=NONE cterm=NONE
highlight Ignore guifg=#090e12 ctermfg=0 gui=NONE cterm=NONE
highlight PreProc guifg=#5c7897 ctermfg=8 gui=bold cterm=bold
highlight! link Delimiter Normal
highlight! link Identifier Normal
highlight! link Operator Normal
highlight! link Error ErrorMsg
highlight! link Statement Keyword
highlight! link Type Keyword
highlight! link String Constant
highlight! link Number Constant
highlight! link Boolean Constant

"}}}
" Diff {{{
highlight diffAdded guifg=#beda3f ctermfg=2 gui=NONE cterm=NONE
highlight diffRemoved guifg=#ff2b68 ctermfg=1 gui=NONE cterm=NONE
highlight! link diffFile PreProc
highlight! link diffLine Title
highlight SignifySignAdd guifg=#beda3f ctermfg=2 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight SignifySignChange guifg=#bcaa85 ctermfg=3 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight SignifySignDelete guifg=#ff2b68 ctermfg=1 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
highlight! link SignifySignChangeDelete SignifySignChange
highlight! link SignifySignDeleteFirstLine SignifySignDelete

"}}}

" vim: fdm=marker:sw=2:sts=2:et
