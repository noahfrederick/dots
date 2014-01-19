" syntax/spore.vim - Spore plug-in manager buffer syntax
" Maintainer:   Noah Frederick

syntax region sporeHelp start=+^" + end=+$+ contains=sporeHelpChar,sporeHelpDelimiter concealends
syntax match sporeHelpChar "(.)" contained contains=sporeHelpCharDelimiter
syntax match sporeHelpCharDelimiter "[()]" contained conceal
syntax match sporeHelpDelimiter /^" / contained conceal

syntax region sporeTitle start="^# " end="$" contains=sporeTitleDelimiter concealends
syntax match sporeTitleDelimiter /^# / contained conceal

syntax region sporeBundle start="^+ " end="$" contains=sporeBundleDelimiter,sporeBundleRepoOwner,sporeBundlePrefix,sporeBundleIgnore concealends
syntax region sporeBundleMissing start="^- " end="$" contains=sporeBundlePrefix concealends
syntax match sporeBundlePrefix /^[+-]\ze / contained conceal
syntax match sporeBundleRepoOwner "[a-zA-Z0-9_-]\+\ze/" contained
syntax match sporeBundleDelimiter "/" contained
syntax match sporeBundleIgnore /\(vim-\|\.vim\)/ contained

highlight default link sporeHelp Comment
highlight default link sporeHelpChar Special
highlight default link sporeHelpCharDelimiter Ignore
highlight default link sporeHelpDelimiter Ignore
highlight default link sporeTitle Statement
highlight default link sporeTitleDelimiter Ignore
highlight default link sporeBundle Identifier
highlight default link sporeBundleRepoOwner Comment
highlight default link sporeBundleMissing Error
highlight default link sporeBundlePrefix Ignore
highlight default link sporeBundleIgnore Delimiter
highlight default link sporeBundleDelimiter sporeBundleIgnore

" vim: fdm=marker:sw=2:sts=2:et
