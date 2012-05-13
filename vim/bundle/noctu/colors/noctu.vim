" noctu.vim - Vim color scheme
" ----------------------------------------------------------
" Author:	Noah Frederick (http://noahfrederick.com/)
" Version:	0.1.0
" ----------------------------------------------------------

" Scheme setup {{{
set background=dark
hi! clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "noctu"

"}}}
" Vim UI {{{
hi CursorLine	ctermbg=0	cterm=NONE
hi MatchParen	ctermfg=15	ctermbg=0
hi Pmenu	ctermbg=0
hi PmenuThumb	ctermbg=7
hi PmenuSBar	ctermbg=8
hi PmenuSel	ctermbg=4
hi ColorColumn	ctermbg=0
hi SpellBad	ctermbg=1
hi SpellCap	ctermbg=3
hi SpellRare	ctermbg=2
hi SpellLocal	ctermbg=5
hi NonText	ctermfg=8
hi LineNr	ctermfg=8	ctermbg=0
hi Visual	ctermfg=0	ctermbg=12
hi IncSearch	ctermbg=0	ctermfg=10 " Yes, fg and bg need to be reversed for some reason.
hi Search	ctermfg=0	ctermbg=14
hi StatusLine	ctermfg=7	ctermbg=0	cterm=bold
hi StatusLineNC	ctermfg=8	ctermbg=0	cterm=NONE
hi VertSplit	ctermfg=0	ctermbg=0
hi TabLine	ctermfg=8	ctermbg=0	cterm=NONE
hi TabLineSel	ctermfg=7	ctermbg=0
hi Folded	ctermfg=8	ctermbg=0
hi Directory	ctermfg=12
hi Title	ctermfg=3	cterm=bold
hi ErrorMsg	ctermfg=15	ctermbg=1
hi DiffAdd	ctermbg=2
hi DiffChange	ctermbg=3
hi DiffDelete	ctermbg=1
hi DiffText	ctermbg=1	cterm=bold
hi User1	ctermfg=0	ctermbg=10
hi User2	ctermfg=0	ctermbg=9
hi User3	ctermfg=0	ctermbg=7
hi! link CursorColumn CursorLine
hi! link SignColumn Normal
hi! link WildMenu Visual
hi! link FoldColumn SignColumn
hi! link WarningMsg ErrorMsg
hi! link MoreMsg Title
hi! link Question MoreMsg
hi! link ModeMsg MoreMsg
hi! link TabLineFill StatusLineNC
hi! link SpecialKey NonText
hi! clear Ignore

"}}}
" Generic syntax {{{
hi Delimiter	ctermfg=7
hi Comment	ctermfg=8
hi Underlined	ctermfg=4	cterm=underline
hi Type	ctermfg=4
hi String	ctermfg=9
hi Keyword	ctermfg=2
hi Todo	ctermfg=1
hi Function	ctermfg=4
hi Identifier	ctermfg=7	cterm=NONE
hi Statement	ctermfg=2	cterm=bold
hi Constant	ctermfg=5
hi Number	ctermfg=13
hi Special	ctermfg=5
hi! link Operator Delimiter
hi! link PreProc Delimiter
hi! link Error ErrorMsg

"}}}
" HTML {{{
hi htmlTag	ctermfg=10
hi htmlTagName	ctermfg=2
hi! link htmlArg htmlTag
hi! link htmlLink Underlined
hi! link htmlEndTag htmlTag

"}}}
" Markdown {{{
hi! link markdownHeadingRule NonText
hi! link markdownHeadingDelimiter markdownHeadingRule
hi! link markdownLinkDelimiter Delimiter
hi! link markdownURLDelimiter Delimiter
hi! link markdownLinkTextDelimiter markdownLinkDelimiter
hi! link markdownUrl markdownLinkDelimiter
hi! link markdownAutomaticLink markdownLinkText
hi markdownCode	cterm=bold
hi markdownBold	cterm=bold
hi markdownItalic	cterm=underline

"}}}
" Ruby {{{
hi! link rubyDefine Statement
hi! link rubyLocalVariableOrMethod Identifier
hi! link rubyConstant Constant

"}}}
" Git {{{
hi gitCommitBranch	ctermfg=3
hi gitCommitSelectedType	ctermfg=10
hi gitCommitSelectedFile	ctermfg=2
hi gitCommitUnmergedType	ctermfg=9
hi gitCommitUnmergedFile	ctermfg=1
hi! link gitCommitUntrackedFile gitCommitUnmergedFile

"}}}
" Vim {{{
hi! link vimSetSep Delimiter
hi! link vimContinue Delimiter
hi! link vimHiAttrib Constant

"}}}
" NERDTree {{{
hi! link NERDTreeHelp Comment
hi! link NERDTreeExecFile String

"}}}

" vim: ts=16:fdm=marker
