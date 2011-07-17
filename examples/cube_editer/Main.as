﻿package  
{
	import fl.events.ColorPickerEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	
	import com.risonhuang.pixas.math.Coord3D;
	import com.risonhuang.pixas.math.ColorPattern;
	import com.risonhuang.pixas.colors.CubeColor;
	import com.risonhuang.pixas.dimensions.CubeDms;
	import com.risonhuang.pixas.objects.primitives.Cube;
	import com.risonhuang.pixas.objects.PixelObject;

	/**
	 * @author rison
	 */	
	public class Main extends Sprite
	{
		private var xDms:uint;
		private var yDms:uint;
		private var zDms:uint;
		private var axis:String;
		private var count:int;
		private var cubeColor:CubeColor;
		private var pCube:PixelObject;
		private var po:PixelObject;
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//砖块在像素坐标系的尺寸定义
			xDms = 60;
			yDms = 60;
			zDms = 60;
			axis = "x";
			//enterframe判断依据
			count = 2;
			
			//外层像素对象
			po = new PixelObject();
			po.x = 220;
			po.y = 140;			
			
			//cube
			cubeColor = CubeColor.getByHorizontalColor(ColorPattern.PINK);
			pCube = new PixelObject();
			updateCube();
			
			//控制区域
			color_picker.selectedColor = ColorPattern.PINK;
			color_picker.addEventListener(ColorPickerEvent.CHANGE,onColorChange);
			pane.btn_x_plus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_x_plus.addEventListener(MouseEvent.MOUSE_UP,__onBtnUp);
			pane.btn_x_minus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_x_minus.addEventListener(MouseEvent.MOUSE_UP, __onBtnUp);
			pane.btn_y_plus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_y_plus.addEventListener(MouseEvent.MOUSE_UP,__onBtnUp);
			pane.btn_y_minus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_y_minus.addEventListener(MouseEvent.MOUSE_UP,__onBtnUp);
			pane.btn_z_plus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_z_plus.addEventListener(MouseEvent.MOUSE_UP,__onBtnUp);
			pane.btn_z_minus.addEventListener(MouseEvent.MOUSE_DOWN,__onBtnDown);
			pane.btn_z_minus.addEventListener(MouseEvent.MOUSE_UP,__onBtnUp);
			
			//深度排序
			addChild(po);
			addChild(pane);
			addChild(color_picker);
		}
		
		private function onColorChange(event:ColorPickerEvent):void
		{
			cubeColor = CubeColor.getByHorizontalColor(event.target.selectedColor);
			updateCube();
		}
		
		private function __onBtnDown(e:MouseEvent):void
		{
			if (e.target.name.indexOf("plus") > 0)
			{
				count = 2;

			} else
			{
				count = -2;
			}

			if (e.target.name.indexOf("_x_") > 0)
			{
				axis = "x";
			} else
			{
				if (e.target.name.indexOf("_y_") > 0)
				{
					axis = "y";
				} else
				{
					axis = "z";
				}
			}
			addEventListener(Event.ENTER_FRAME,__enterFrame);
		}
		
		private function __onBtnUp(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME,__enterFrame);
		}
		
		private function __enterFrame(e:Event):void
		{
			if (axis == "x")
			{
				xDms += count;
			} else
			{
				if (axis=="y")
				{
					yDms+=count;
				} else
				{
					zDms+=count;
				}
			}
			//最小界限
			if (xDms<6)
			{
				xDms=6;
			}
			if (yDms<6)
			{
				yDms=6;
			}
			if (zDms<4)
			{
				zDms=4;
			}
			updateCube();
		}
		
		private function updateCube()
		{
			pCube.removeAllChildren();
			po.removeAllChildren();

			//刷新pixelobject,由于尺寸变化,则必须重绘,重新生成Cube原型.
			var cubeDms:CubeDms=new CubeDms(xDms,yDms,zDms);
			var cube:Cube=new Cube(cubeDms,cubeColor);
			pCube=new PixelObject(cube);
			po.addChild(pCube);
		}
	}
}