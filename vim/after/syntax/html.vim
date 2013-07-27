" Highlight Big Tech's ASP placeholders

syntax region AspPlaceholder matchgroup=AspPlaceholderDelimiter
       \ start=/<%':: / end=/ ::'%>/

highlight default link AspPlaceholder Keyword
highlight default link AspPlaceholderDelimiter Delimiter
