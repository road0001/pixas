package com.risonhuang.pixas.dimensions 
{
	/**
	 * The PyramidDms class represents the dimensions of a pyramid
	 *
	 * @author	rison
	 */
	public class PyramidDms extends AbstractDms
	{
		
		/**
		 * Construct
		 *
		 * @param	_axis [optional] The dimension in 2.5D pixel coordinate
		 * @param	_tall [optional] Whether a tall pyramid
		 */		
		public function PyramidDms(_axis:uint = 30, _tall:Boolean = false) 
		{
			super();
			
			xAxis = _axis;
			yAxis = _axis;
			zAxis = _tall ? _axis*2 : _axis;
			
			if (xAxis % 2 == 1)
			{
				throw new Error("x,yAxis must be even number");
			}
			
			if (xAxis <= 4)
			{
				throw new Error("dimension is too small");
			}
		}
	}
}