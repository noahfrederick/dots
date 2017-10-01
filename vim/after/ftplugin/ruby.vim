setlocal foldmethod=syntax
setlocal foldlevel=2

let b:surround_{char2nr('i')} = "%i{\r}" " Array of symbols
let b:surround_{char2nr('Q')} = "%Q{\r}" " Double-quoted string
let b:surround_{char2nr('q')} = "%q{\r}" " Single-quoted string
let b:surround_{char2nr('r')} = "%r{\r}" " Regular expression
let b:surround_{char2nr('s')} = "%s{\r}" " Symbol
let b:surround_{char2nr('W')} = "%W{\r}" " Array of words as if double-quoted
let b:surround_{char2nr('w')} = "%w{\r}" " Array of words as if single-quoted
let b:surround_{char2nr('x')} = "%x{\r}" " System command (backticks)

let b:accio = ['ruby', 'rubocop']

call my#filetype#make_rocket_maps()
