package  
{

	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	
	import com.risonhuang.pixas.math.Coord3D;
	import com.risonhuang.pixas.colors.SideColor;
	import com.risonhuang.pixas.dimensions.BrickDms;
	import com.risonhuang.pixas.objects.primitives.Brick;
	import com.risonhuang.pixas.objects.PixelObject;	
	/**
	 * @author rison
	 */	
	public class Main extends Sprite
	{
		private var xDms:uint;
		private var yDms:uint;
		private var zDms:uint;
		private var po:PixelObject;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//砖块在像素坐标系的尺寸定义
			xDms = 30;
			yDms = 30;
			zDms = 0;
			
			//外层像素对象
			po = new PixelObject();
			po.x = 220;
			po.y = 60;
			//砖块尺寸对象
			var brickDms:BrickDms = new BrickDms(xDms,yDms);
			//砖块颜色对象,透明度,需要定义透明度可以传递aRGB颜色如:0x99FFFFFF
			var sideColorA:SideColor = new SideColor(0xFF777777);
			var sideColorB:SideColor = new SideColor(0xFF777777,0xFFCCCCCC);
			//砖块原型生成
			var brickA:Brick = new Brick(brickDms,sideColorA);
			var brickB:Brick = new Brick(brickDms,sideColorB);

			//排列
			for (var i:int = 0; i <= 6; i++)
			{
				for (var j:int = 0; j <= 6; j++)
				{
					//砖块像素坐标系位置
					var int3d_tmp:Coord3D = new Coord3D((xDms - 2) * i, (yDms - 2) * j, 0);
					//像素对象内 nesting 其他像素对象
					var po_tmp:PixelObject;
					//颜色隔开
					if ((i+j)%2==0)
					{
						po_tmp = new PixelObject(brickA,int3d_tmp);
					} else
					{
						po_tmp = new PixelObject(brickB,int3d_tmp);
					}
					po.addChild(po_tmp);
				}
			}
			addChild(po);
		}
	}
}