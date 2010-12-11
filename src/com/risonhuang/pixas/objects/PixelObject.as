package com.risonhuang.pixas.objects 
{
	import com.risonhuang.pixas.math.Int3D;
	import flash.display.Sprite;
	
	/**
	 * The PixelObject class represents instances of pixel objects.
	 * Single PixelObject instance could only nest SINGLE primitive.
	 * Cube,for instance.
	 * But, it could contain different PixelObjects as many as you want.
	 * It extends from Sprite,which means you can operate it as a normal Sprite.
	 *
	 * @author	rison
	 * @example	see the examples folder
	 */
	public class PixelObject extends Sprite
	{
		
		private var pos:Int3D;
		private var pmt:AbstractPrimitive;
		
		/**
		 * construct
		 *
		 * @param	_pmt	[optional]	The primitive(if it nests certain primitive) of the obj
		 * @param	_pos	[optional]	The pixel 3d postion of the obj
		 */
		public function PixelObject(_pmt:AbstractPrimitive = null,_pos:Int3D = null) 
		{
			
			if (_pmt != null)
			{
				generate(_pmt);
			}
			
			if (_pos == null)
			{
				pos = new Int3D();
			}
			else
			{
				pos = _pos
			}

			place();
		}
				
		/**
		 * Remove all the children of the instance
		 */		
		public function removeAllChild():void
		{
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
		
		/**
		 * Add new attribute of the PixelObject
		 * One could change the primitive by apply instance.primitive
		 * Or by pass the primitive in Construct
		 *
		 * @param	_pmt	The pixel object primitive(if it nests certain primitive)
		 */
		public function set primitive(_pmt:AbstractPrimitive):void
		{
			pmt = _pmt;
			generate(pmt);
		}

		public function get primitive():AbstractPrimitive
		{
			return pmt;
		}
		
		/**
		 * One could change the primitive by apply instance.primitive
		 * Or by pass the primitive in Construct
		 *
		 * @param	_pos	The pixel object 3d Pixel position
		 */
		public function set position(_pos:Int3D):void
		{
			pos = _pos;
			place();
		}

		public function get position():Int3D
		{
			return pos;
		}
		
		/**
		 * One could get positionX,Y,Z by postion.x
		 *
		 * @param	_posX	The position in X axis
		 * @param	_posY	The position in Y axis
		 * @param	_posZ	The position in Z axis
		 */
		public function set positionX(_posX:int):void
		{
			pos = new Int3D(_posX,pos.y,pos.z);
			place();
		}
		
		public function get positionX():int
		{
			return pos.x;
		}
		
		public function set positionY(_posY:int):void
		{
			pos = new Int3D(pos.x,_posY,pos.z);
			place();
		}
		
		public function get positionY():int
		{
			return pos.y;
		}
		
		public function set positionZ(_posZ:int):void
		{
			pos = new Int3D(pos.x,pos.y,_posZ);
			place();
		}

		public function get positionZ():int
		{
			return pos.z;
		}
		
		
		private function generate(_pmt:AbstractPrimitive):void
		{
			removeAllChild();
			addChild(_pmt.generate());
		}
		
		private function place():void
		{
			x = pos.x - pos.y;
			y = - pos.z + Math.floor (pos.x / 2 + pos.y / 2);
		}
		
	}

}