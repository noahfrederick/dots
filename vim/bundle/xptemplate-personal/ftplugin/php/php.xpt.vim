XPTemplate priority=personal+

XPTinclude
	\ _common/common


let s:f = g:XPTfuncs()

" Infer the PSR-0 class name from file's path.
" Example:
"   /some/path/to/classes/HTTP/Request.php
"   ->  HTTP_Request
" (File must be under a "classes" or "tests" directory.)
function! s:f.ClassNameFromPath()
	" Get path without extension and with "_" for "/"
	let className = expand('%:p:gs?/?_?:r')
	" Truncate up to the last classes/tests path component
	let className = substitute(className, '\v.*_(classes|tests)_', '', '')

	return (className == '' || className =~ '^_') ? 'ClassName' : className
endfunction

" Derive class name from test class name
" Example:
"   HTTP_RequestTest -> HTTP_Request
function! s:TestClassNameToClassName(className)
	return substitute(a:className, 'Test$', '', '')
endfunction

" Derive test class name from class name
" Example:
"   HTTP_Request -> HTTP_RequestTest
function! s:ClassNameToTestClassName(className)
	return a:className.'Test'
endfunction

" Generate a generic description for test case
function! s:f.GetTestCaseDescription()
	let className = s:f.ClassNameFromPath()
	let className = s:TestClassNameToClassName(className)
	
	return 'Test case for class '.className
endfunction


XPT foreach " foreach (.. as ..) {..}
XSET val|post=EchoIfEq(' => $', '')
foreach`$SPcmd^($`var^ as $`key^` => $`val`^)`$BRloop^{
    `cursor^
}

XPT asso " array (.. => ..);
array(
    `...^'`key^' => `value^,
    `...^
)

XPT fun " function ..( .. ) {..}
XSET arg*|post=EchoIfEq('arg*', '')
XSET arg*|post=ExpandIfNotEmpty(', ', 'arg*')
function `fun_name^(`arg*^)`$BRfun^{
    `cursor^
}

XPT @param syn=phpComment " @param  type  \$var  Description
@param   `p_type^  $`p_name^  `p_desc^

XPT @var syn=phpComment " @var  type  \$var  Description
@var  `p_type^  $`p_name^  `p_desc^

XPT @return syn=phpComment " @return  type  Description
@return  `r_type^  `r_desc^

XPT docMethod " /* Method doc block */
/**
 * `description^
 * `...^
 * `:@param:^`...^
 * `:@return:^
 */

XPT _method hidden " $_xSnipName function ..( .. ) {..}
XSET arg*|post=EchoIfEq('arg*', '')
XSET arg*|post=ExpandIfNotEmpty(', ', 'arg*')
`:docMethod:^
`access^ function `fun_name^(`arg*^)`$BRfun^{
    `cursor^
}

XPT public    alias=_method
XSET access=$_xSnipName
XPT protected alias=_method
XSET access=$_xSnipName
XPT private   alias=_method
XSET access=$_xSnipName
XPT method    alias=_method
XSET access=ChooseStr( 'public', 'protected', 'private' )

XPT docProperty " /* Property doc block */
/**
 * `:@var:^
 */

XPT property " .. $.. = ..;
XSET value=Void()
XSET value|post=EchoIfEq(' = ', '')
XSET access=ChooseStr( 'public', 'protected', 'private' )
`:docProperty:^
`access^ $`p_name^` = `value`^;

..XPT

XPT license " /* License comment block */
/* THE FOLLOWING NOTICE MAY NOT BE REMOVED UNDER ANY CIRCUMSTANCES
 * ---------------------------------------------------------------
 * noahfrederick.com ("Author") grants a non-exclusive, non-transferable
 * and non-assignable license to use this script ("Software") solely by
 * and for the benefit of `client^ ("Licensee"). Licensee shall not
 * permit the removal of any existing copyright notice or other
 * restrictive or proprietary notice from the Software. The Software
 * may not be used by or delivered to any third party. Licensee shall
 * not make any copies of the Software or any portion thereof except as
 * a backup or with express written consent from the Author.
 */

..XPT

XPT class " class .. extends .. { .. }
XSET category=ChooseStr( 'Controllers', 'Models', 'Helpers', 'Tasks', 'Tests' )
XSET className=ClassNameFromPath()
XSET parentClassName|post=EchoIfEq(' extends parentClassName', '')
/**
 * `description^.
 *
 * @package    `package^
 * @category   `category^
 * @author     `$author^
 * @copyright  `:copyright:^
 */ 
class `className^` extends `parentClassName`^`$BRfun^{
    `cursor^
}

XPT koconfig " Kohana config file
return `:asso:^;

XPT _phpunitassert hidden " \$this->$_xSnipName( .. );
XSET arg*|post=ExpandIfNotEmpty(', ', 'arg*')
$this->`$_xSnipName^(`arg*^);

XPT assertEquals    alias=_phpunitassert
XPT assertNotEquals alias=_phpunitassert
XPT assertSame      alias=_phpunitassert
XPT assertNotSame   alias=_phpunitassert
XPT assertTrue      alias=_phpunitassert
XPT assertFalse     alias=_phpunitassert
XPT assertNull      alias=_phpunitassert
XPT assertNotNull   alias=_phpunitassert
XPT assertEmpty     alias=_phpunitassert
XPT assertNotEmpty  alias=_phpunitassert
XPT assertObjectHasAttribute    alias=_phpunitassert
XPT assertObjectNotHasAttribute alias=_phpunitassert

XPT unittestcase    alias=class
XSET parentClassName=PHPUnit_Framework_TestCase
XSET description=GetTestCaseDescription()
XSET category=Tests
