package com.risonhuang.pixas.dimensions 
{
	/**
	 * The SideXDms class represents the dimensions of a x axis side
	 *
	 * @author	rison
	 */
	public class SideXDms extends AbstractDms
	{
		
		/**
		 * construct
		 *
		 * @param	_xAxis	[optional]	The x dimension in 2.5D pixel coordinate
		 * @param	_zAxis	[optional]	The z dimension in 2.5D pixel coordinate
		 */		
		public function SideXDms(_xAxis:uint = 30,_zAxis:uint = 30) 
		{
			super();
			
			xAxis = _xAxis;
			yAxis = 0;
			zAxis = _zAxis;
			
			if (xAxis % 2 == 1)
			{
				throw new Error("xAxis must be even number");
			}
			
			// xAxis || yAxis = 4 || zAxis = 2 the bitmap cannot apply floodFill
			if (xAxis <= 4 || zAxis <=2 )
			{
				throw new Error("dimension is too small");
			}			
		}		
	}

}