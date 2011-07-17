package  
{
	import fl.events.ColorPickerEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	
	import com.risonhuang.pixas.math.Coord3D;
	import com.risonhuang.pixas.math.ColorPattern;
	import com.risonhuang.pixas.colors.PyramidColor;
	import com.risonhuang.pixas.dimensions.PyramidDms;
	import com.risonhuang.pixas.objects.primitives.Pyramid;
	import com.risonhuang.pixas.objects.PixelObject;

	/**
	 * @author rison
	 */	
	public class Main extends Sprite
	{
		private var tall:Boolean;
		private var dms:uint;
		private var count:int;
		private var pyramidColor:PyramidColor;
		private var pPyramid:PixelObject;
		private var po:PixelObject;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//砖块在像素坐标系的尺寸定义
			dms = 60;
			//enterframe判断依据
			count = 2;
			//是否为高pyramid
			tall = false;
			
			//外层像素对象
			po = new PixelObject();
			po.x = 220;
			po.y = 140;			
			
			//pyramid
			pyramidColor = PyramidColor.getByRightColor(ColorPattern.PINK);
			pPyramid = new PixelObject();
			updatePyramid();
			
			//控制区域
			pane.btn_big.addEventListener(MouseEvent.CLICK, __onBtnSizeClick);
			pane.btn_small.addEventListener(MouseEvent.CLICK, __onBtnSizeClick);
			color_picker.selectedColor = ColorPattern.PINK;
			color_picker.addEventListener(ColorPickerEvent.CHANGE,onColorChange);
			pane.btn_x_plus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_x_plus.addEventListener(MouseEvent.MOUSE_UP,__onBtnUp);
			pane.btn_x_minus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_x_minus.addEventListener(MouseEvent.MOUSE_UP, __onBtnUp);
			
			//深度排序
			addChild(po);
			addChild(pane);
			addChild(color_picker);
		}
		
		private function onColorChange(event:ColorPickerEvent):void
		{
			pyramidColor = PyramidColor.getByRightColor(event.target.selectedColor);
			updatePyramid();
		}
		
		private function __onBtnSizeClick(e:MouseEvent):void
		{
			tall = pane.btn_big.visible;
			pane.btn_big.visible = !pane.btn_big.visible;
			updatePyramid();
		}
		
		private function __onBtnDown(e:MouseEvent):void
		{
			if (e.target.name.indexOf("plus") > 0)
			{
				count = 2;
			}
			else
			{
				count = -2;
			}
			addEventListener(Event.ENTER_FRAME,__enterFrame);
		}
		
		private function __onBtnUp(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME,__enterFrame);
		}
		
		private function __enterFrame(e:Event):void
		{
			dms += count;
			//最小界限
			if (dms<6)
			{
				dms=6;
			}
			//最小界限
			if (dms>300)
			{
				dms=300;
			}

			updatePyramid();
		}
		
		private function updatePyramid()
		{
			pPyramid.removeAllChildren();
			po.removeAllChildren();

			//刷新pixelobject,由于尺寸变化,则必须重绘,重新生成Pyramid原型.
			var pyramidDms:PyramidDms=new PyramidDms(dms,tall);
			var pyramid:Pyramid=new Pyramid(pyramidDms,pyramidColor);
			pPyramid=new PixelObject(pyramid);
			po.addChild(pPyramid);
		}
	}
}