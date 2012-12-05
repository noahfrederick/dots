" noctu.vim - Vim color scheme
" --------------------------------------------------------------
" Author:	Noah Frederick (http://noahfrederick.com/)
" Version:	0.1.5
" --------------------------------------------------------------

" Scheme setup {{{
set background=dark
hi! clear

if exists("syntax_on")
	syntax reset
endif

let colors_name="noctu"

"}}}
" Vim UI {{{
hi Normal	guifg=#e6e6e6	guibg=#000000
hi Cursor	guifg=#ffffff	guibg=#005f87
hi CursorLine	ctermbg=0	guibg=#101010	cterm=NONE
hi MatchParen	ctermfg=15	guifg=#ffffff	ctermbg=9	guibg=#101010
hi Pmenu	ctermbg=0	guibg=#101010
hi PmenuThumb	ctermbg=7	guibg=#dfdfdf
hi PmenuSBar	ctermbg=8	guibg=#546572
hi PmenuSel	ctermfg=0	guifg=#000000	ctermbg=4	guibg=#67b0d4
hi ColorColumn	ctermbg=0	guibg=#101010
hi SpellBad	ctermbg=1	guisp=#ff7158
hi SpellCap	ctermbg=3	guisp=#d6bd83
hi SpellRare	ctermbg=2	guisp=#ceeb87
hi SpellLocal	ctermbg=5	guisp=#b0aada
hi NonText	ctermfg=8	guifg=#546572
hi LineNr	ctermfg=8	guifg=#546572	ctermbg=0	guibg=#101010
hi Visual	ctermfg=0	guifg=#000000	ctermbg=12	guibg=#a4d5f3
hi IncSearch	ctermbg=0	guibg=#000000	ctermfg=13	guifg=#b0aada " Yes, fg and bg need to be reversed for some reason.
hi Search	ctermfg=0	guifg=#000000	ctermbg=14	guibg=#8dd4d6
hi StatusLine	ctermfg=7	guifg=#dfdfdf	ctermbg=0	guibg=#101010	cterm=bold	gui=bold
hi StatusLineNC	ctermfg=8	guifg=#546572	ctermbg=0	guibg=#101010	cterm=NONE	gui=NONE
hi VertSplit	ctermfg=0	guifg=#101010	ctermbg=0	guibg=#101010
hi TabLine	ctermfg=8	guifg=#546572	ctermbg=0	guibg=#101010	cterm=NONE	gui=NONE
hi TabLineSel	ctermfg=7	guifg=#dfdfdf	ctermbg=0	guibg=#101010
hi Folded	ctermfg=8	guifg=#546572	ctermbg=0	guibg=#101010
hi Directory	ctermfg=12	guifg=#a4d5f3
hi Title	ctermfg=3	guifg=#ae9b72	cterm=bold	gui=bold
hi ErrorMsg	ctermfg=15	guifg=#ffffff	ctermbg=1	guibg=#ff2114
hi DiffAdd	ctermbg=2	guibg=#9ab929
hi DiffChange	ctermbg=3	guibg=#ae9b72
hi DiffDelete	ctermbg=1	guibg=#ff2114
hi DiffText	ctermbg=11	guibg=#d6bd83	cterm=bold	gui=bold
hi User1	ctermfg=0	guifg=#000000	ctermbg=13	guibg=#b0aada
hi User2	ctermfg=0	guifg=#000000	ctermbg=9	guibg=#ff7158
hi User3	ctermfg=0	guifg=#000000	ctermbg=7	guibg=#dfdfdf
hi! link CursorColumn	CursorLine
hi! link SignColumn	Normal
hi! link WildMenu	Visual
hi! link FoldColumn	SignColumn
hi! link WarningMsg	ErrorMsg
hi! link MoreMsg	Title
hi! link Question	MoreMsg
hi! link ModeMsg	MoreMsg
hi! link TabLineFill	StatusLineNC
hi! link SpecialKey	NonText

"}}}
" Generic syntax {{{
hi Delimiter	ctermfg=7	guifg=#dfdfdf
hi Comment	ctermfg=8	guifg=#546572
hi Underlined	ctermfg=4	guifg=#67b0d4	cterm=underline
hi Type	ctermfg=4	guifg=#67b0d4	gui=NONE
hi String	ctermfg=9	guifg=#ff7158
hi Keyword	ctermfg=2	guifg=#9ab929
hi Todo	ctermbg=11	guibg=#d6bd83	ctermfg=0	guifg=#000000	cterm=bold	gui=bold
hi Function	ctermfg=4	guifg=#67b0d4
hi Identifier	ctermfg=7	guifg=#dfdfdf	cterm=NONE	gui=NONE
hi Statement	ctermfg=2	guifg=#9ab929	cterm=bold	gui=bold
hi Constant	ctermfg=5	guifg=#856fd3
hi Number	ctermfg=12	guifg=#a4d5f3
hi Boolean	ctermfg=4	guifg=#67b0d4
hi Special	ctermfg=5	guifg=#856fd3
hi Ignore	ctermfg=0	guifg=#000000
hi! link Operator	Delimiter
hi! link PreProc	Delimiter
hi! link Error	ErrorMsg

"}}}
" HTML {{{
hi htmlTagName	ctermfg=2	guifg=#9ab929
hi htmlTag	ctermfg=10	guifg=#ceeb87
hi htmlBold	cterm=bold	gui=bold
hi htmlItalic	gui=italic
hi htmlUnderline	cterm=underline	gui=underline
hi htmlBoldItalic	cterm=bold	gui=bold,italic
hi htmlBoldUnderline	cterm=bold,underline	gui=bold,underline
hi htmlUnderlineItalic	cterm=underline	gui=italic,underline
hi htmlBoldUnderlineItalic	cterm=bold,underline	gui=bold,italic,underline
hi! link htmlArg	htmlTag
hi! link htmlString	htmlTagName	" Definitely more legible
hi! link htmlLink	Underlined
hi! link htmlEndTag	htmlTag

"}}}
" XML {{{
hi xmlTagName	ctermfg=4	guifg=#67b0d4
hi xmlTag	ctermfg=12	guifg=#a4d5f3
hi! link xmlString	xmlTagName
hi! link xmlAttrib	xmlTag
hi! link xmlEndTag	xmlTag
hi! link xmlEqual	xmlTag

"}}}
" JavaScript {{{
hi! link javaScript	Normal
hi! link javaScriptBraces	Delimiter

"}}}
" PHP {{{
hi phpSpecialFunction	ctermfg=5	guifg=#856fd3
hi phpIdentifier	ctermfg=11	guifg=#d6bd83
hi! link phpVarSelector	phpIdentifier
hi! link phpHereDoc	String
hi! link phpDefine	Statement

"}}}
" Markdown {{{
hi! link markdownHeadingRule	NonText
hi! link markdownHeadingDelimiter	markdownHeadingRule
hi! link markdownLinkDelimiter	Delimiter
hi! link markdownURLDelimiter	Delimiter
hi! link markdownCodeDelimiter	NonText
hi! link markdownLinkTextDelimiter	markdownLinkDelimiter
hi! link markdownUrl	markdownLinkDelimiter
hi! link markdownAutomaticLink	markdownLinkText
hi markdownCode	cterm=bold	gui=bold
hi markdownBold	cterm=bold	gui=bold
hi markdownItalic	cterm=underline	gui=italic

"}}}
" Ruby {{{
hi! link rubyDefine	Statement
hi! link rubyLocalVariableOrMethod	Identifier
hi! link rubyConstant	Constant
hi! link rubyInstanceVariable	Number
hi! link rubyStringDelimiter	rubyString

"}}}
" Git {{{
hi gitCommitBranch	ctermfg=3	guifg=#ae9b72
hi gitCommitSelectedType	ctermfg=10	guifg=#ceeb87
hi gitCommitSelectedFile	ctermfg=2	guifg=#9ab929
hi gitCommitUnmergedType	ctermfg=9	guifg=#ff7158
hi gitCommitUnmergedFile	ctermfg=1	guifg=#ff2114
hi! link gitCommitUntrackedFile	gitCommitUnmergedFile

"}}}
" Vim {{{
hi! link vimSetSep	Delimiter
hi! link vimContinue	Delimiter
hi! link vimHiAttrib	Constant

"}}}
" LESS {{{
hi lessVariable	ctermfg=11	guifg=#d6bd83
hi! link lessVariableValue	Normal

"}}}
" NERDTree {{{
hi! link NERDTreeHelp	Comment
hi! link NERDTreeExecFile	String

"}}}
" Vimwiki {{{
hi! link VimwikiHeaderChar	markdownHeadingDelimiter
hi! link VimwikiList	markdownListMarker
hi! link VimwikiCode	markdownCode
hi! link VimwikiCodeChar	markdownCodeDelimiter

"}}}
" Help {{{
hi! link helpExample	String
hi! link helpHeadline	Title
hi! link helpSectionDelim	Comment
hi! link helpHyperTextEntry	Statement
hi! link helpHyperTextJump	Underlined
hi! link helpURL	Underlined

"}}}

" vim: ts=22:fdm=marker
