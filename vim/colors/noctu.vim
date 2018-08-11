" noctu.vim - Vim color scheme for 16-color terminals
" --------------------------------------------------------------
" Author:   Noah Frederick (https://noahfrederick.com/)
" Version:  2.0.0
" --------------------------------------------------------------

" Scheme setup {{{
set background=dark
hi! clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'noctu'

"}}}
" Vim UI {{{
hi Normal              ctermfg=NONE
hi Cursor              ctermfg=15    ctermbg=1
hi CursorLine          ctermbg=0     cterm=NONE
hi MatchParen          ctermfg=0     ctermbg=5
hi Pmenu               ctermfg=NONE  ctermbg=0
hi PmenuThumb          ctermbg=7
hi PmenuSBar           ctermbg=8
hi PmenuSel            ctermfg=0     ctermbg=4
hi ColorColumn         ctermbg=0
hi EndOfBuffer         ctermfg=0
hi SpellBad            ctermfg=9     ctermbg=NONE  cterm=underline
hi SpellCap            ctermfg=10    ctermbg=NONE  cterm=underline
hi SpellRare           ctermfg=11    ctermbg=NONE  cterm=underline
hi SpellLocal          ctermfg=13    ctermbg=NONE  cterm=underline
hi NonText             ctermfg=8
hi LineNr              ctermfg=8     ctermbg=NONE
hi CursorLineNr        ctermfg=11    ctermbg=0
hi Visual              ctermfg=0     ctermbg=12
hi IncSearch           ctermfg=0     ctermbg=13    cterm=NONE
hi Search              ctermfg=0     ctermbg=10
hi StatusLine          ctermfg=NONE  ctermbg=0     cterm=bold
hi StatusLineNC        ctermfg=8     ctermbg=0     cterm=bold
hi VertSplit           ctermfg=0     ctermbg=0     cterm=NONE
hi TabLine             ctermfg=8     ctermbg=0     cterm=bold
hi TabLineSel          ctermfg=0     ctermbg=7     cterm=bold
hi Folded              ctermfg=8     ctermbg=0     cterm=bold
hi Conceal             ctermfg=6     ctermbg=NONE
hi Directory           ctermfg=12
hi Title               ctermfg=3     cterm=bold
hi ErrorMsg            ctermfg=15    ctermbg=1
hi WarningMsg          ctermfg=15    ctermbg=3
hi DiffAdd             ctermfg=0     ctermbg=2
hi DiffChange          ctermfg=0     ctermbg=3
hi DiffDelete          ctermfg=0     ctermbg=1
hi DiffText            ctermfg=0     ctermbg=11    cterm=bold
hi User1               ctermfg=1     ctermbg=0
hi User2               ctermfg=2     ctermbg=0
hi User3               ctermfg=3     ctermbg=0
hi User4               ctermfg=4     ctermbg=0
hi User5               ctermfg=5     ctermbg=0
hi User6               ctermfg=6     ctermbg=0
hi User7               ctermfg=7     ctermbg=0
hi User8               ctermfg=8     ctermbg=0
hi User9               ctermfg=15    ctermbg=5
hi! link CursorColumn  CursorLine
hi! link SignColumn    LineNr
hi! link WildMenu      Visual
hi! link FoldColumn    SignColumn
hi! link MoreMsg       Title
hi! link Question      MoreMsg
hi! link ModeMsg       NonText
hi! link TabLineFill   StatusLineNC
hi! link SpecialKey    NonText

"}}}
" Generic syntax {{{
hi Delimiter       ctermfg=7
hi Comment         ctermfg=8   cterm=italic
hi Underlined      ctermfg=4   cterm=underline
hi Type            ctermfg=4
hi String          ctermfg=11
hi Keyword         ctermfg=2
hi Todo            ctermfg=15  ctermbg=NONE     cterm=bold,underline
hi Function        ctermfg=4
hi Identifier      ctermfg=7   cterm=NONE
hi Statement       ctermfg=2   cterm=bold
hi Constant        ctermfg=13
hi Number          ctermfg=12
hi Boolean         ctermfg=4
hi Special         ctermfg=13
hi Ignore          ctermfg=0
hi PreProc         ctermfg=8   cterm=bold
hi! link Operator  Delimiter
hi! link Error     ErrorMsg

"}}}
" Quickfix Window {{{
hi! link qfSeparator        PreProc
hi! link qfRedundantPath    Delimiter

"}}}
" HTML {{{
hi htmlTagName              ctermfg=2
hi htmlTag                  ctermfg=2
hi htmlArg                  ctermfg=10
hi htmlH1                   cterm=bold
hi htmlBold                 cterm=bold
hi htmlItalic               cterm=italic
hi htmlUnderline            cterm=underline
hi htmlBoldItalic           cterm=bold,underline
hi htmlBoldUnderline        cterm=bold,underline
hi htmlUnderlineItalic      cterm=underline
hi htmlBoldUnderlineItalic  cterm=bold,underline
hi! link htmlLink           Underlined
hi! link htmlEndTag         htmlTag

"}}}
" XML {{{
hi xmlTagName       ctermfg=4
hi xmlTag           ctermfg=12
hi! link xmlString  xmlTagName
hi! link xmlAttrib  xmlTag
hi! link xmlEndTag  xmlTag
hi! link xmlEqual   xmlTag

"}}}
" JavaScript {{{
hi! link javaScript        Normal
hi! link javaScriptBraces  Delimiter

"}}}
" PHP {{{
hi phpSpecialFunction    ctermfg=5
hi phpIdentifier         ctermfg=13
hi phpParent             ctermfg=8
hi! link phpVarSelector  phpIdentifier
hi! link phpHereDoc      String
hi! link phpDefine       Statement

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
hi markdownBold                     cterm=bold
hi markdownItalic                   cterm=italic
" Polyglot ftplugin
hi! link mkdListItem                htmlTagName

"}}}
" Ruby {{{
hi! link rubyDefine                 Statement
hi! link rubyLocalVariableOrMethod  Identifier
hi! link rubyConstant               Constant
hi! link rubyInstanceVariable       Number
hi! link rubyStringDelimiter        rubyString
hi! link yardGenericTag             PreProc
hi! link yardGenericDirective       yardGenericTag

"}}}
" Git {{{
hi gitCommitBranch               ctermfg=3
hi gitCommitSelectedType         ctermfg=10
hi gitCommitSelectedFile         ctermfg=2
hi gitCommitUnmergedType         ctermfg=9
hi gitCommitUnmergedFile         ctermfg=1
hi! link gitCommitFile           Directory
hi! link gitCommitUntrackedFile  gitCommitUnmergedFile
hi! link gitCommitDiscardedType  gitCommitUnmergedType
hi! link gitCommitDiscardedFile  gitCommitUnmergedFile
hi gvSha                         ctermfg=8

"}}}
" Vim {{{
hi! link vimSetSep    Delimiter
hi! link vimContinue  Delimiter
hi! link vimHiAttrib  Constant

"}}}
" CSS {{{
hi       cssIdentifier                ctermfg=9
hi! link cssBraces                    Delimiter
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
hi! link cssPageProp                  cssProperty
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
hi lessVariable             ctermfg=11
hi! link lessVariableValue  Normal

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
hi! link CtrlPMatch    String
hi! link CtrlPLinePre  Comment

"}}}
" Mustache {{{
hi mustacheSection           ctermfg=13  cterm=bold
hi mustacheUnescape          ctermfg=9
hi mustachePartial           ctermfg=13
hi mustacheHandlebars        ctermfg=5

"}}}
" Shell {{{
hi shDerefSimple     ctermfg=11
hi! link shDerefVar  shDerefSimple

"}}}
" Syntastic / Neomake {{{
hi SyntasticWarningSign       ctermfg=3  ctermbg=NONE
hi SyntasticErrorSign         ctermfg=1  ctermbg=NONE
hi SyntasticStyleWarningSign  ctermfg=4  ctermbg=NONE
hi SyntasticStyleErrorSign    ctermfg=4  ctermbg=NONE
hi! link NeomakeWarningSign   SyntasticWarningSign
hi! link NeomakeErrorSign     SyntasticErrorSign
hi! link NeomakeMessageSign   SyntasticStyleWarningSign
hi! link NeomakeInfoSign      SyntasticStyleWarningSign
hi! link ALEWarningSign       SyntasticWarningSign
hi! link ALEErrorSign         SyntasticErrorSign
hi! link ALEInfoSign          SyntasticStyleWarningSign

"}}}
" Netrw {{{
hi netrwExe       ctermfg=9
hi netrwClassify  ctermfg=8  cterm=bold

"}}}
" Ledger {{{
hi ledgerAccount  ctermfg=11
hi! link ledgerMetadata  Comment
hi! link ledgerTransactionStatus  Statement

"}}}
" Diff {{{
hi diffAdded  ctermfg=2
hi diffRemoved  ctermfg=1
hi! link diffFile  PreProc
hi! link diffLine  Title

hi SignifySignAdd                   ctermfg=2 ctermbg=NONE
hi SignifySignChange                ctermfg=3 ctermbg=NONE
hi SignifySignDelete                ctermfg=1 ctermbg=NONE
hi! link SignifySignChangeDelete    SignifySignChange
hi! link SignifySignDeleteFirstLine SignifySignDelete

"}}}
" Plug {{{
hi plugSha  ctermfg=3

"}}}
" Blade {{{
hi! link bladeStructure  PreProc
hi! link bladeParen      phpParent
hi! link bladeEchoDelim  PreProc

"}}}
" YAML {{{
hi! link yamlPlainScalar  String
hi! link yamlConstant     Constant

"}}}

" vim: fdm=marker:sw=2:sts=2:et
