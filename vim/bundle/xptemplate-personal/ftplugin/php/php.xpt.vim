XPTemplate priority=personal+

XPTinclude
	\ _common/common

XPT foreach " foreach (.. as ..) {..}
XSET val|post=EchoIfEq(' => $', '')
foreach ($`var^ as $`key^` => $`val`^)`$BRloop^{
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

XPT class " class .. extends .. { .. }
XSET parentClassName|post=EchoIfEq(' extends parentClassName', '')
class `className^` extends `parentClassName`^`$BRfun^{
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

XPT docKoclass " /* Kohana class doc block */
XSET category=ChooseStr( 'Controllers', 'Models', 'Helpers', 'Tasks', 'Tests' )
/**
 * `description^.
 *
 * @package    `package^
 * @category   `category^
 * @author     `$author^
 * @copyright  `:copyright:^
 */

XPT koclass " Kohana class file
`:koclassDoc:^
`:class:^

XPT koconfig " Kohana config file
return `:asso:^;

XPT _phpunit hidden " \$this->$_xSnipName( .. );
XSET arg*|post=ExpandIfNotEmpty(', ', 'arg*')
$this->`$_xSnipName^(`arg*^);

XPT assertEquals    alias=_phpunit
XPT assertNotEquals alias=_phpunit
XPT assertSame      alias=_phpunit
XPT assertNotSame   alias=_phpunit
XPT assertTrue      alias=_phpunit
XPT assertFalse     alias=_phpunit
XPT assertEmpty     alias=_phpunit
XPT assertNotEmpty  alias=_phpunit
