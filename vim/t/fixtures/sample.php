<?php

/**
 * Example PHP file with various types of methods.
 *
 * @package    (Project Title)
 * @category   Helpers
 * @author     Noah Frederick
 * @copyright  © 2014 Noah Frederick
 */
class ChildClass extends ParentClass {

	public function fun_name()
	{
		return true;
	}

	private function priv_fun_name()
	{
		return true;
	}

	protected function protected_fun_name()
	{
		return true;
	}

	public function empty_fun()
	{
	}

	public function brace_fun() {
		return true;
	}

	function plain_fun()
	{
		return true;
	}

	public function fun_with_args(ChildClass $class, $whatever = null)
	{
		return $class->fun_name($whatever);
	}

	public function fun_with_multiline_args(
		$one,
		$two,
		$three
	) {
		return false;
	}

	public function fun_with_blocks()
	{
		if (true)
		{
			return 123;
		}

		return 321;
	}

}
