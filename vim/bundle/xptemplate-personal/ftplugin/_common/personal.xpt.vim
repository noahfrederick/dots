" Move me to your own fptlugin/_common and config your personal information.
"
" Here is the place to set personal preferences; "priority=personal" is the
" highest which overrides any other XPTvar setting.
XPTemplate priority=personal

XPTvar $author       Noah Frederick
XPTvar $email        noah@noahfrederick.com

" int fun( ** arg ** )
" if ( ** condition ** )
" for ( ** statement ** )
" [ ** a, b ** ]
" { ** 'k' : 'v' ** }
XPTvar $SParg    ''

" if ** (
XPTvar $SPcmd    ' '

" if () ** {
" else ** {
XPTvar $BRif     \n

" } ** else {
XPTvar $BRel     \n

" for () ** {
" while () ** {
" do ** {
XPTvar $BRloop   \n

" struct name ** {
XPTvar $BRstc    \n

" int fun() ** {
" class name ** {
XPTvar $BRfun    \n