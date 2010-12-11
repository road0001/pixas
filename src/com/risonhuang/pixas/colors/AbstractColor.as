package com.risonhuang.pixas.colors 
{
	
	/**
	 * The AbstractColor class is the super Class of certains color obj
	 *
	 * @author	rison
	 */
	public class AbstractColor
	{
		/**
		 * The inner colors for elements of certain primitive
		 */
		public var inner:uint;

		/**
		 * The border colors for elements of certain primitive
		 */
		public var border:uint;
		
		/**
		 * The borderHighlight colors for elements of certain primitive
		 */
		public var borderHighlight:uint;

		/**
		 * The left side colors for elements of certain primitive
		 */
		public var left:uint;
		
		/**
		 * The right side colors for elements of certain primitive
		 */
		public var right:uint;
		
		/**
		 * The horizontal colors for elements of certain primitive
		 */
		public var horizontal : uint;
		
		public function AbstractColor() 
		{
			
		}
		
	}

}