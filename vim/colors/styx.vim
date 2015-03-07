" styx.vim - Vim color scheme for GUI
" --------------------------------------------------------------
" Author:   Noah Frederick (http://noahfrederick.com/)
" --------------------------------------------------------------

" Scheme setup {{{
set background=dark
hi! clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "styx"

"}}}
" Vim UI {{{
hi Normal              guifg=#d2d2d2  guibg=#1a1a1a
hi Cursor              guifg=#ffffff  guibg=#4da9f0
hi CursorLine          guibg=#222222  gui=NONE
hi MatchParen          guifg=#ffffff  guibg=#264049  gui=underline  guisp=#539dbd
hi Pmenu               guifg=#ffffff  guibg=#000000
hi PmenuThumb          guibg=#d2d2d2
hi PmenuSBar           guibg=#444444
hi PmenuSel            guifg=#000000  guibg=#539dbd
hi ColorColumn         guibg=#000000
hi SpellBad            guisp=#ffb6c0  guibg=NONE     gui=undercurl
hi SpellCap            guisp=#cde88a  guibg=NONE     gui=undercurl
hi SpellRare           guisp=#b7aa80  guibg=NONE     gui=undercurl
hi SpellLocal          guisp=#d6b8f5  guibg=NONE     gui=undercurl
hi NonText             guifg=#444444
hi LineNr              guifg=#444444  guibg=NONE
hi CursorLineNr        guifg=#539dbd  guibg=#222222  gui=NONE
hi EndOfBuffer         guifg=#1a1a1a
hi Visual              guibg=#264049
hi IncSearch           guifg=#000000  guibg=#d6b8f5  gui=NONE
hi Search              guifg=#000000  guibg=#cde88a
hi Wildmenu            guifg=#ffffff  guibg=#1f333a  gui=bold
hi StatusLine          guifg=#ffffff  guibg=#151515  gui=NONE
hi StatusLineNC        guifg=#888888  guibg=#151515  gui=NONE
hi VertSplit           guifg=#111111  guibg=NONE     gui=NONE
hi Folded              guifg=#138791  guibg=#151515  gui=bold,italic,underline  guisp=#1a1a1a
hi Directory           guifg=#93c3d6  gui=bold
hi Title               guifg=#e9d9b3  gui=bold
hi SpecialKey          guifg=#1c6068
hi Conceal             guifg=#539dbd  guibg=NONE
hi ErrorMsg            guifg=#ffffff  guibg=#ff0055
hi WarningMsg          guifg=#ffffff  guibg=#b7aa80
hi DiffAdd             guifg=#000000  guibg=#b1d631
hi DiffChange          guifg=#000000  guibg=#b7aa80
hi DiffDelete          guifg=#000000  guibg=#ff0055
hi DiffText            guifg=#000000  guibg=#e9d9b3  gui=bold
hi User1               guifg=#ff0055  guibg=#151515  " Modified
hi User2               guifg=#539dbd  guibg=#151515  " Special
hi User3               guifg=#b1d631  guibg=#151515  " Readonly
hi User4               guifg=#000000  guibg=#bbbbbb  " CtrlP default (indluding files)
hi User5               guifg=#000000  guibg=#b7aa80  " CtrlP buffers
hi User6               guifg=#000000  guibg=#ffb6c0  " CtrlP MRU files
hi User7               guifg=#000000  guibg=#93c3d6  " CtrlP bookmarks
hi User8               guifg=#000000  guibg=#d6b8f5  " CtrlP tags
hi User9               guifg=#000000  guibg=#b1d631  " CtrlP runtime scripts
hi! link CursorColumn  CursorLine
hi! link SignColumn    LineNr
hi! link FoldColumn    SignColumn
hi! link MoreMsg       Title
hi! link Question      MoreMsg
hi! link ModeMsg       MoreMsg
hi! link TablineSel    StatusLine
hi! link Tabline       StatusLineNC
hi! link TabLineFill   Tabline

"}}}
" Generic syntax {{{
hi Delimiter       guifg=#b8b8b8
hi Comment         guifg=#888888  gui=italic
hi Underlined      guifg=#93c3d6  gui=underline
hi Type            guifg=#e9d9b3  gui=none
hi String          guifg=#93c3d6
hi Keyword         guifg=#e9d9b3  gui=bold
hi Todo            guifg=#ffffff  guibg=NONE     gui=underline  guisp=#ffb6c0
hi Function        guifg=#e9d9b3
hi Identifier      guifg=#d2d2d2  gui=NONE
hi Statement       guifg=#b1d631  gui=bold
hi Constant        guifg=#d6b8f5
hi Number          guifg=#93c3d6
hi Boolean         guifg=#93c3d6
hi Special         guifg=#d6b8f5
hi Ignore          guifg=#444444
hi PreProc         guifg=#888888  gui=bold
hi! link Operator  Delimiter
hi! link Error     ErrorMsg

"}}}
" HTML {{{
hi htmlTagName              guifg=#b1d631
hi htmlTag                  guifg=#b1d631
hi htmlArg                  guifg=#cde88a
hi htmlH1                   guifg=#ffffff  gui=bold
hi htmlBold                 gui=bold
hi htmlItalic               gui=italic
hi htmlUnderline            gui=underline
hi htmlBoldItalic           gui=bold,italic
hi htmlBoldUnderline        gui=bold,underline
hi htmlUnderlineItalic      gui=underline,italic
hi htmlBoldUnderlineItalic  gui=bold,underline,italic
hi! link htmlLink           Underlined
hi! link htmlEndTag         htmlTag

"}}}
" XML {{{
hi xmlTagName            guifg=#93c3d6
hi xmlTag                guifg=#93c3d6
hi xmlAttrib             guifg=#bce2f1
hi! link xmlString       String
hi! link xmlEndTag       xmlTag
hi! link xmlEqual        xmlTag
hi! link xmlEntity       htmlSpecialChar
hi! link xmlEntityPunct  xmlEntity

"}}}
" JavaScript {{{
hi! link javaScript            Normal
hi! link javaScriptBraces      Delimiter
hi! link javaScriptParens      Delimiter
hi! link javaScriptIdentifier  Keyword
hi! link javaScriptNumber      Number

"}}}
" PHP {{{
hi phpSpecialFunction    guifg=#d6b8f5
hi phpIdentifier         guifg=#b7aa80
hi! link phpVarSelector  phpIdentifier
hi! link phpHereDoc      String
hi! link phpDefine       Statement
hi! link phpParent       Normal

"}}}
" Markdown {{{
hi! link markdownHeadingRule        NonText
hi! link markdownHeadingDelimiter   markdownHeadingRule
hi! link markdownLinkDelimiter      Delimiter
hi! link markdownURLDelimiter       Delimiter
hi! link markdownCodeDelimiter      NonText
hi! link markdownLinkTextDelimiter  markdownLinkDelimiter
hi! link markdownUrl                markdownLinkText
hi! link markdownAutomaticLink      markdownLinkText
hi! link markdownCodeBlock          String
hi! link markdownCode               String
hi markdownBold                     gui=bold
hi markdownItalic                   gui=italic

hi! link markdownTitleBlock         markdownListMarker

hi markdownOrgTodo                  guifg=#ffb6c0  gui=bold
hi markdownOrgDone                  guifg=#cde88a  gui=bold
hi markdownOrgCanceled              guifg=#888888  gui=bold
hi markdownOrgWaiting               guifg=#e9d9b3  gui=bold

"}}}
" Ruby {{{
hi! link rubyDefine                 Statement
hi! link rubyLocalVariableOrMethod  Identifier
hi! link rubyConstant               Constant
hi! link rubyInstanceVariable       Number
hi! link rubyStringDelimiter        rubyString

"}}}
" Diff {{{
hi diffAdded  guifg=#b1d631
hi diffRemoved  guifg=#ff0055
hi! link diffFile  PreProc
hi! link diffLine  Title

"}}}
" Git {{{
hi gitCommitBranch               guifg=#e9d9b3
hi gitCommitSelectedType         guifg=#cde88a
hi gitCommitSelectedFile         guifg=#b1d631
hi gitCommitUnmergedType         guifg=#ffb6c0
hi gitCommitUnmergedFile         guifg=#ff0055
hi! link gitCommitFile           Directory
hi! link gitCommitUntrackedFile  gitCommitUnmergedFile
hi! link gitCommitDiscardedType  gitCommitUnmergedType
hi! link gitCommitDiscardedFile  gitCommitUnmergedFile

hi GitGutterAdd                  guifg=#b1d631
hi GitGutterChange               guifg=#b7aa80
hi GitGutterDelete               guifg=#ff0055
hi! link GitGutterChangeDelete   GitGutterChange

"}}}
" Vim {{{
hi! link vimSetSep    Delimiter
hi! link vimOption    Keyword
hi! link vimContinue  Delimiter
hi! link vimHiAttrib  Constant

"}}}
" NERDTree {{{
hi! link NERDTreeHelp      Comment
hi! link NERDTreeExecFile  String

"}}}
" Vimwiki {{{
hi! link VimwikiHeaderChar  markdownHeadingDelimiter
hi! link VimwikiList        markdownListMarker
hi! link VimwikiCode        markdownCode
hi! link VimwikiCodeChar    markdownCodeDelimiter

"}}}
" Help {{{
hi! link helpExample         String
hi! link helpHeadline        Title
hi! link helpSectionDelim    Comment
hi! link helpHyperTextEntry  Statement
hi! link helpHyperTextJump   Underlined
hi! link helpURL             Underlined

"}}}
" CtrlP {{{
hi CtrlPMatch          guifg=#ffb6c0  guisp=#A5757B  gui=underline
hi! link CtrlPLinePre  Comment

"}}}
" Mustache {{{
hi mustacheSection           guifg=#739ba3  gui=bold
hi mustacheMarker            guifg=#1c6068
hi mustacheVariable          guifg=#739ba3
hi mustacheVariableUnescape  guifg=#ffb6c0
hi mustachePartial           guifg=#d6b8f5

"}}}
" Syntastic {{{
hi SyntasticWarningSign  guifg=#b7aa80  guibg=NONE
hi SyntasticErrorSign    guifg=#ff0055  guibg=NONE
" hi SyntasticWarningLine  guisp=#b7aa80  gui=undercurl
" hi SyntasticErrorLine    guisp=#ff0055  gui=undercurl

"}}}
" CSS {{{
hi cssNoise                           guifg=#888888
hi cssIdentifier                      guifg=#ffb6c0 gui=bold
hi cssClassName                       guifg=#e9d9b3 gui=bold
hi! link cssStyle                     Delimiter
hi! link cssBraces                    Delimiter
" CSS syntax file sucks and doesn't link to a common cssProperty group
hi! link cssProperty                  Normal
hi! link cssAnimationProp             cssProperty
hi! link cssBackgroundProp            cssProperty
hi! link cssBorderOutlineProp         cssProperty
hi! link cssBorderProp                cssProperty
hi! link cssBoxProp                   cssProperty
hi! link cssColorProp                 cssProperty
hi! link cssContentForPagedMediaProp  cssProperty
hi! link cssDimensionProp             cssProperty
hi! link cssFlexibleBoxProp           cssProperty
hi! link cssFontProp                  cssProperty
hi! link cssGeneratedContentProp      cssProperty
hi! link cssGridProp                  cssProperty
hi! link cssHyerlinkProp              cssProperty
hi! link cssLineboxProp               cssProperty
hi! link cssListProp                  cssProperty
hi! link cssMarginProp                cssProperty
hi! link cssMarqueeProp               cssProperty
hi! link cssMultiColumnProp           cssProperty
hi! link cssPaddingProp               cssProperty
hi! link cssPagedMediaProp            cssProperty
hi! link cssPositioningProp           cssProperty
hi! link cssPrintProp                 cssProperty
hi! link cssRubyProp                  cssProperty
hi! link cssSpeechProp                cssProperty
hi! link cssTableProp                 cssProperty
hi! link cssTextProp                  cssProperty
hi! link cssTransformProp             cssProperty
hi! link cssTransitionProp            cssProperty
hi! link cssUIProp                    cssProperty
" LESS syntax file uses cssUIAttr instead of cssUIProp
hi! link cssUIAttr                    cssProperty
hi! link cssAuralProp                 cssProperty
hi! link cssRenderProp                cssProperty

"}}}
" LESS {{{
hi lessVariable                  guifg=#b7aa80
hi! link lessVariableValue       Normal
hi! link lessVariableAssignment  Delimiter
hi! link lessMixinChar           Delimiter
hi! link lessClass               cssClassName

"}}}
" CSV {{{
hi! link CSVColumnOdd         Normal
hi! link CSVColumnEven        Comment
hi! link CSVColumnHeaderOdd   Title
hi CSVColumnHeaderEven        guifg=#b7aa80 gui=bold

"}}}
" Quickfix list {{{
hi! link qfLineNr             Statement
hi! link qfSeparator          NonText

"}}}
" vim: fdm=marker:sw=2:sts=2:et
