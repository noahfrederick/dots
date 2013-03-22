XPTemplate priority=personal+

XPTinclude
	\ _common/common


XPT % " Preamble
% `title^
% `$author^
% `prettyDate()^

..XPT

XPT ul " - Unordered list
- `item...^
`...^- `item^
`...^

XPT ol " 1. Ordered list
1. `item...^
`...^1. `item^
`...^

XPT list alias=ul