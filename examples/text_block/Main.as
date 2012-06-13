package  
{
	import fl.events.ColorPickerEvent;
	
	import flash.display.BitmapData;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import com.risonhuang.pixas.math.Coord3D;
	import com.risonhuang.pixas.math.ColorPattern;
	import com.risonhuang.pixas.colors.CubeColor;
	import com.risonhuang.pixas.dimensions.CubeDms;
	import com.risonhuang.pixas.objects.primitives.Cube;
	import com.risonhuang.pixas.objects.PixelObject;
	import com.risonhuang.pixas.colors.SideColor;
	import com.risonhuang.pixas.dimensions.BrickDms;
	import com.risonhuang.pixas.objects.primitives.Brick;
	/**
	 * @author rison
	 */	
	public class Main extends Sprite
	{
		private var bmd:BitmapData;
		private var txt:TextField;
		private var border:Boolean;
		private var xDms:uint;
		private var yDms:uint;
		private var zDms:uint;
		private var poFloor:PixelObject;
		private var poTxt:PixelObject;
		private var cube:Cube;
		private var brick:Brick;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			//砖块在像素坐标系的尺寸定义
			xDms = 16;
			yDms = 16;
			zDms = 20;
			
			//是否描边
			border = false;

			//颜色
			color_picker.selectedColor = ColorPattern.WINE_RED;
			color_picker.addEventListener(ColorPickerEvent.CHANGE,__onColorChange);			
			//txt
			txt = txt_mc.txt;
			txt_mc.txt_name.text = "Please Input:";
			txt.border = true;
			txt.borderColor = 0xBBBBBB;
			txt.background = true;
			txt.backgroundColor = 0xFFFFFF;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.text = "iMessage";
			txt.addEventListener(Event.CHANGE, __onTxtChange);

			//像素对象
			var po:PixelObject = new PixelObject();
			//地板像素对象
			poFloor = new PixelObject();
			//砖块原型生成
			var brickDms:BrickDms = new BrickDms(xDms,yDms);
			var sideColor:SideColor = new SideColor(0xBBBBBB);
			brick = new Brick(brickDms,sideColor);
			//text像素对象
			poTxt = new PixelObject();
			//cube原型生成
			var cubeDms:CubeDms = new CubeDms(xDms,yDms,zDms);
			var cubeColor:CubeColor = CubeColor.getByHorizontalColor(ColorPattern.WINE_RED);
			cube = new Cube(cubeDms, cubeColor, border);
			
			//add to stage
			po.addChild(poFloor);
			po.addChild(poTxt);
			po.x = 173;
			po.y = 60;
			
			addChild(po);
			addChild(txt_mc);
			addChild(color_picker);

			__onTxtChange(null);
			
		}
		
		private function __onColorChange(event:ColorPickerEvent):void
		{
			//cube原型生成
			var cubeDms:CubeDms = new CubeDms(xDms,yDms,zDms);
			var cubeColor:CubeColor = CubeColor.getByHorizontalColor(event.target.selectedColor);
			cube = new Cube(cubeDms, cubeColor, border);
			__onTxtChange(null);
		}
		
		private function __onTxtChange(e:Event):void
		{
			txt_mc.bg.width = txt.textWidth + txt.x + 15;
			var txtWidth:uint = txt.textWidth;
			var txtHeight:uint = txt.textHeight;
			try
			{
				poFloor.removeAllChildren();
				poTxt.removeAllChildren();

				bmd.dispose();
			}
			catch (e)
			{
			}

			try
			{
				bmd = new BitmapData(txtWidth,txtHeight);
				bmd.draw(txt);
			}
			catch (e:Error)
			{
				return;
			}

			var p_y:uint = 0;
			var p_x:uint = 0;

			for (p_y=0; p_y<txtHeight - 1; p_y++)
			{
				for (p_x =0; p_x<txtWidth; p_x++)
				{
					var int3d:Coord3D = new Coord3D((xDms - 2) * p_x, (yDms - 2) * p_y, 0);
					//地砖
					var po_brick:PixelObject = new PixelObject(brick,int3d);
					poFloor.addChild(po_brick);
					//txt块
					if (bmd.getPixel(p_x,p_y) < 0x999999)
					{
						var po_cube:PixelObject = new PixelObject(cube,int3d);
						poTxt.addChild(po_cube);
					}
				}
			}
		}
	}
}











