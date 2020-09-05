" noctu.vim - Vim color scheme
"
" This is a generated file. See colorscheme.rb.

" Setup {{{
highlight! clear

if exists('g:syntax_on')
  syntax reset
endif

let g:colors_name = 'noctu'

"}}}
" Vim UI {{{
highlight Normal guifg=#eeeeee ctermfg=NONE guibg=#0e191b ctermbg=NONE gui=NONE cterm=NONE
highlight Cursor guifg=#090e12 ctermfg=0 guibg=#eeeeee ctermbg=7 gui=NONE cterm=NONE
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
" User {{{
highlight User1 guifg=#ff2b68 ctermfg=1 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User2 guifg=#78c9e9 ctermfg=4 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User3 guifg=#beda3f ctermfg=2 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User4 guifg=#bcaa85 ctermfg=3 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User5 guifg=#b88eec ctermfg=5 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User6 guifg=#68a9af ctermfg=6 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User7 guifg=#eeeeee ctermfg=7 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User8 guifg=#5c7897 ctermfg=8 guibg=#090e12 ctermbg=0 gui=NONE cterm=NONE
highlight User9 guifg=#ffffff ctermfg=15 guibg=#b88eec ctermbg=5 gui=NONE cterm=NONE

"}}}
" Generic Syntax {{{
highlight Comment guifg=#5c7897 ctermfg=8 gui=italic cterm=italic
highlight Constant guifg=#ebd0ea ctermfg=13 gui=NONE cterm=NONE
highlight Function guifg=NONE ctermfg=NONE gui=italic cterm=italic
highlight Ignore guifg=#090e12 ctermfg=0 gui=NONE cterm=NONE
highlight Keyword guifg=#beda3f ctermfg=2 gui=NONE cterm=NONE
highlight Number guifg=#addbeb ctermfg=12 gui=NONE cterm=NONE
highlight PreProc guifg=#5c7897 ctermfg=8 gui=bold cterm=bold
highlight Statement guifg=#beda3f ctermfg=2 gui=bold cterm=bold
highlight String guifg=#ddd4c1 ctermfg=11 gui=NONE cterm=NONE
highlight Todo guifg=#ffffff ctermfg=15 guibg=NONE ctermbg=NONE gui=bold,underline cterm=bold,underline
highlight Type guifg=#78c9e9 ctermfg=4 gui=NONE cterm=NONE
highlight Underlined guifg=#78c9e9 ctermfg=4 gui=underline cterm=underline
highlight! link Boolean Type
highlight! link Delimiter Normal
highlight! link Error ErrorMsg
highlight! link Identifier Normal
highlight! link Operator Delimiter
highlight! link Special Constant

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
" Quickfix Window {{{
highlight! link qfSeparator PreProc
highlight! link qfRedundantPath Delimiter

"}}}
" HTML {{{
highlight htmlTagName guifg=#beda3f ctermfg=2 gui=NONE cterm=NONE
highlight htmlTag guifg=#beda3f ctermfg=2 gui=NONE cterm=NONE
highlight htmlArg guifg=#c5fcb8 ctermfg=10 gui=NONE cterm=NONE
highlight htmlH1 gui=bold cterm=bold
highlight htmlBold gui=bold cterm=bold
highlight htmlItalic gui=italic cterm=italic
highlight htmlUnderline gui=underline cterm=underline
highlight htmlBoldItalic gui=bold,italic cterm=bold,italic
highlight htmlBoldUnderline gui=bold,underline cterm=bold,underline
highlight htmlUnderlineItalic gui=underline,italic cterm=underline,italic
highlight htmlBoldUnderlineItalic gui=bold,underline,italic cterm=bold,underline,italic
highlight! link htmlLink Underlined
highlight! link htmlEndTag htmlTag

"}}}
" XML {{{
highlight xmlTagName guifg=#78c9e9 ctermfg=4 gui=NONE cterm=NONE
highlight xmlTag guifg=#addbeb ctermfg=12 gui=NONE cterm=NONE
highlight! link xmlString xmlTagName
highlight! link xmlAttrib xmlTag
highlight! link xmlEndTag xmlTag
highlight! link xmlEqual xmlTag

"}}}
" JavaScript {{{
highlight! link javaScript Normal
highlight! link javaScriptBraces Delimiter

"}}}
" PHP {{{
highlight phpIdentifier guifg=#ddd4c1 ctermfg=11 gui=NONE cterm=NONE
highlight! link phpSpecialFunction Function
highlight! link phpVarSelector phpIdentifier
highlight! link phpHereDoc String
highlight! link phpDefine Statement
highlight! link phpDocTags PreProc

"}}}
" Markdown {{{
highlight! link markdownHeadingRule NonText
highlight! link markdownHeadingDelimiter markdownHeadingRule
highlight! link markdownLinkDelimiter Delimiter
highlight! link markdownURLDelimiter Delimiter
highlight! link markdownCodeDelimiter NonText
highlight! link markdownLinkTextDelimiter markdownLinkDelimiter
highlight! link markdownUrl markdownLinkText
highlight! link markdownAutomaticLink markdownLinkText
highlight! link markdownCodeBlock String
highlight! link markdownCode String
highlight markdownBold gui=bold cterm=bold
highlight markdownItalic gui=italic cterm=italic
highlight! link mkdListItem htmlTagName
highlight markdownBlockquoteLevel1 guifg=#78c9e9 ctermfg=4 gui=NONE cterm=NONE
highlight markdownBlockquoteLevel2 guifg=#beda3f ctermfg=2 gui=NONE cterm=NONE
highlight markdownBlockquoteLevel3 guifg=#b88eec ctermfg=5 gui=NONE cterm=NONE

"}}}
" Ruby {{{
highlight! link rubyDefine Statement
highlight! link rubyLocalVariableOrMethod Identifier
highlight! link rubyConstant Constant
highlight! link rubyInstanceVariable Number
highlight! link rubyStringDelimiter rubyString
highlight! link yardGenericTag PreProc
highlight! link yardGenericDirective yardGenericTag

"}}}
" Git {{{
highlight gitCommitBranch guifg=#78c9e9 ctermfg=4 gui=NONE cterm=NONE
highlight gitCommitSelectedType guifg=#c5fcb8 ctermfg=10 gui=NONE cterm=NONE
highlight gitCommitSelectedFile guifg=#beda3f ctermfg=2 gui=NONE cterm=NONE
highlight gitCommitUnmergedType guifg=#fdc2bd ctermfg=9 gui=NONE cterm=NONE
highlight gitCommitUnmergedFile guifg=#ff2b68 ctermfg=1 gui=NONE cterm=NONE
highlight! link gitCommitFile Directory
highlight! link gitCommitUntrackedFile gitCommitUnmergedFile
highlight! link gitCommitDiscardedType gitCommitUnmergedType
highlight! link gitCommitDiscardedFile gitCommitUnmergedFile
highlight fugitiveHash guifg=#5c7897 ctermfg=8 gui=NONE cterm=NONE
highlight! link gvSha fugitiveHash

"}}}
" Vim {{{
highlight! link vimSetSep Delimiter
highlight! link vimContinue Delimiter
highlight! link vimHiAttrib Constant

"}}}
" CSS {{{
highlight cssIdentifier guifg=#fdc2bd ctermfg=9 gui=NONE cterm=NONE
highlight! link cssBraces Delimiter
highlight! link cssProperty Normal
highlight! link cssAnimationProp cssProperty
highlight! link cssBackgroundProp cssProperty
highlight! link cssBorderOutlineProp cssProperty
highlight! link cssBorderProp cssProperty
highlight! link cssBoxProp cssProperty
highlight! link cssColorProp cssProperty
highlight! link cssContentForPagedMediaProp cssProperty
highlight! link cssDimensionProp cssProperty
highlight! link cssFlexibleBoxProp cssProperty
highlight! link cssFontProp cssProperty
highlight! link cssGeneratedContentProp cssProperty
highlight! link cssGridProp cssProperty
highlight! link cssHyerlinkProp cssProperty
highlight! link cssLineboxProp cssProperty
highlight! link cssListProp cssProperty
highlight! link cssMarginProp cssProperty
highlight! link cssMarqueeProp cssProperty
highlight! link cssMultiColumnProp cssProperty
highlight! link cssPaddingProp cssProperty
highlight! link cssPagedMediaProp cssProperty
highlight! link cssPageProp cssProperty
highlight! link cssPositioningProp cssProperty
highlight! link cssPrintProp cssProperty
highlight! link cssRubyProp cssProperty
highlight! link cssSpeechProp cssProperty
highlight! link cssTableProp cssProperty
highlight! link cssTextProp cssProperty
highlight! link cssTransformProp cssProperty
highlight! link cssTransitionProp cssProperty
highlight! link cssUIProp cssProperty
highlight! link cssUIAttr cssProperty
highlight! link cssAuralProp cssProperty
highlight! link cssRenderProp cssProperty

"}}}
" Help {{{
highlight! link helpExample String
highlight! link helpHeadline Title
highlight! link helpSectionDelim Comment
highlight! link helpHyperTextEntry Statement
highlight! link helpHyperTextJump Underlined
highlight! link helpURL Underlined

"}}}
" Mustache {{{
highlight mustacheSection guifg=#ebd0ea ctermfg=13 gui=bold cterm=bold
highlight mustacheUnescape guifg=#fdc2bd ctermfg=9 gui=NONE cterm=NONE
highlight mustachePartial guifg=#ebd0ea ctermfg=13 gui=NONE cterm=NONE
highlight mustacheHandlebars guifg=#b88eec ctermfg=5 gui=NONE cterm=NONE

"}}}
" Shell {{{
highlight! link shDerefSimple String
highlight! link shDerefVar shDerefSimple

"}}}
" Ledger {{{
highlight! link ledgerAccount String
highlight! link ledgerMetadata Comment
highlight! link ledgerTransactionStatus Statement

"}}}
" Plug {{{
highlight! link plugSha fugitiveHash

"}}}
" Blade {{{
highlight! link bladeStructure PreProc
highlight! link bladeParen phpParent
highlight! link bladeEchoDelim PreProc

"}}}
" YAML {{{
highlight! link yamlPlainScalar String
highlight! link yamlConstant Constant

"}}}

" vim: fdm=marker:sw=2:sts=2:et
