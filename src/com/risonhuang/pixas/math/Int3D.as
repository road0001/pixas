package com.risonhuang.pixas.math 
{
	import flash.display.Sprite;

	/**
	 * The Int3D class is the 2.5D pixel position object
	 * The postion should be int only ,considering the pixel graphic
	 *
	 * @author	rison
	 */
	public class Int3D
	{
		/**
		 * The 2.5D pixel position x, y, z
		 */
		public var x:int;
		public var y:int;
		public var z:int;

		/**
		 * construct
		 *
		 * @param	_x	[optional]	The x position in 2.5D pixel coordinate
		 * @param	_y	[optional]	The y position in 2.5D pixel coordinate
		 * @param	_z	[optional]	The z position in 2.5D pixel coordinate
		 */
		public function Int3D(_x:int = 0, _y:int = 0, _z:int = 0) 
		{
			x = _x;
			y = _y;
			z = _z;
		}
		
		public function toString():String
		{
			return "[x : " + x + ", y : " + y + ", z: " + z + "]";
		}
		
	}
}