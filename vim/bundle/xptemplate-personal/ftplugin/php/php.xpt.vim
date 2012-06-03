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
XSET params=Void()
function `fun_name^(`params^)`$BRfun^{
    `cursor^
}

XPT class " class .. extends .. { .. }
XSET parentClassName|post=EchoIfEq(' extends parentClassName', '')
class `className^` extends `parentClassName`^`$BRfun^{
    `cursor^
}

XPT method " .. function ..( .. ) {..}
XSET params=Void()
XSET access=ChooseStr( 'public', 'protected', 'private' )
`access^ function `fun_name^(`params^)`$BRfun^{
    `cursor^
}

XPT _method hidden " $_xSnipName function ..( .. ) {..}
XSET params=Void()
`$_xSnipName^ function `fun_name^(`params^)`$BRfun^{
    `cursor^
}

XPT public    alias=_method
XPT protected alias=_method
XPT private   alias=_method

XPT property " .. $.. = ..;
XSET value=Void()
XSET value|post=EchoIfEq(' = ', '')
XSET access=ChooseStr( 'public', 'protected', 'private' )
`access^ $`property_name^` = `value`^;

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

XPT koclassDoc " Kohana class doc block
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
