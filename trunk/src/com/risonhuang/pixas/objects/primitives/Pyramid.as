package com.risonhuang.pixas.objects.primitives 
{
	import com.risonhuang.pixas.colors.PyramidColor;
	import com.risonhuang.pixas.dimensions.PyramidDms;
	import com.risonhuang.pixas.objects.AbstractPrimitive;
	import com.risonhuang.pixas.objects.PixelObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * The Pyramid class is the primitive for constructing Pyramid
	 * <p/>
	 * The width could be different depends on the dimension
	 *
	 * @author	rison
	 */
	public class Pyramid extends AbstractPrimitive
	{
		
		private var border:Boolean;
		/**
		 * Construct
		 *
		 * @param	_dms	[optional]	the dimension obj for rendering
		 * @param	_color	[optional]	the color obj for rendering
		 * @param	_border [optional]	whether show border and highlight
		 */		
		public function Pyramid(_dms: PyramidDms = null, _color:PyramidColor = null, _border:Boolean = true) 
		{
			super();
			
			border = _border;
			
			initRender(_dms, _color);
			initRectangle();
			initBmd();
			build();
		}

		
		private function initRender(_dms:PyramidDms,_color:PyramidColor):void
		{
			dms = _dms == null ? new PyramidDms() : _dms;
			color = _color == null ? new PyramidColor() : _color;
		}
		
		private function initRectangle():void
		{
			w = dms.xAxis + dms.yAxis;
			h = dms.zAxis + dms.xAxis / 2;
			
			// double 45 ° crossing pixels
			w -= 2;
			h -= (dms.zAxis == dms.xAxis ? 2 : 3);
			
			//the matrix offset between the bitmap and the 3d pixel coordinate ZERO point
			matrix.tx = - dms.xAxis + 2;
			matrix.ty = - dms.zAxis / 2 + 2 - (dms.zAxis == dms.xAxis ? 1 : dms.xAxis / 2);
		}
		
		private function build():void
		{
			var yOffset:uint = dms.zAxis == dms.xAxis ? -2 : -3;
			
			src_bmd.lock();
			
			var color_border_left:uint = border ? color.border : color.left;
			var color_border_right:uint = border ? color.border : color.right;
			
			var color_border_highlight:uint = border?color.borderHighlight:color_border_left;
			
			//z axis || hightlight
			for (var k:uint = 0; k < dms.zAxis + dms.xAxis / 2 - 4 ; k++) 
			{
				src_bmd.setPixel32(dms.xAxis - 2, k +3 + yOffset, color_border_highlight);
			}
			
			//x axis
			for (var i:uint = 0; i < dms.xAxis ; i++) 
			{
				src_bmd.setPixel32(i, dms.zAxis + Math.floor(i / 2) + yOffset, color_border_left);
			}
			//y axis
			for (var j:uint = 0; j< dms.xAxis ; j++) 
			{
				src_bmd.setPixel32(j + dms.xAxis - 2, dms.zAxis + dms.xAxis / 2 - Math.floor(j / 2) - 1 +yOffset, color_border_right);
			}
			
			if (dms.zAxis == dms.xAxis)
			{
				//left edge			
				for (var l1:uint = 0; l1 < dms.zAxis ; l1++) 
				{
					src_bmd.setPixel32(l1, dms.zAxis - l1 + yOffset, color_border_left);
				}
				//right edge
				for (var m1:uint = 0; m1 < dms.zAxis ; m1++) 
				{
					src_bmd.setPixel32(m1 + dms.zAxis - 2, m1 + 1 +yOffset, color_border_right);
				}				
			}
			else
			{
				//left edge			
				for (var l2:uint = 0; l2 < dms.zAxis -2 ; l2++) 
				{
					src_bmd.setPixel32(Math.floor(l2 / 2), dms.zAxis - l2 + yOffset, color_border_left);
				}
				//right edge
				for (var m2:uint = 2; m2 < dms.zAxis ; m2++) 
				{
					src_bmd.setPixel32(Math.floor(m2 / 2) + dms.xAxis - 2, m2 + 1 + yOffset, color_border_right);
				}
			}
			
			//floodfill
			src_bmd.floodFill(dms.xAxis - 1,dms.zAxis + Math.floor((dms.xAxis -1) / 2) + yOffset - 1,  color.right);
			src_bmd.floodFill(dms.xAxis - 3,dms.zAxis + Math.floor((dms.xAxis -1) / 2) + yOffset - 2,  color.left);
			
			src_bmd.unlock();
			
		}
	}

}