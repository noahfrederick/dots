" Vim syntax file
" Language:	Vim help file

" Hide the modeline at the end of help files
if has("conceal")
  syntax match helpModeline "^\s*vim:.*" conceal
  highlight default link helpModeline helpIgnore
endif
