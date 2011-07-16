package com.risonhuang.pixas.dimensions 
{
	/**
	 * The AbstractDms class is the super Class of certains dimension
	 *
	 * @author	rison
	 * @usage	seems there is some building problem in FlashDevelop 
	 * <p/>when you try to access a variable in a child Class
	 * <p/>so I put all of the variables in the AbstractDms Class
	 * 
	 */
	public class AbstractDms
	{
		
		/**
		* The x Axis dimensions in 2.5D pixel coordinate
		*/
		public var xAxis:uint;
		
		/**
		* The y Axis dimensions in 2.5D pixel coordinate
		*/
		public var yAxis:uint;
		
		/**
		* The z Axis dimensions in 2.5D pixel coordinate
		*/
		public var zAxis:uint;
		
		/**
		* Pyramid tall mode 
		*/
		public var tall:Boolean;
		
		public function AbstractDms() 
		{
			
		}
		
	}

}