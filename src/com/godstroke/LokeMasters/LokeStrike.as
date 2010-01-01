package com.godstroke.LokeMasters
{
	import org.flixel.FlxSprite;

	public class LokeStrike extends FlxSprite
	{
		private var _dynamicLength:Number = 0;
		private var _direction:Number = RIGHT;
		private var _draw_back:Boolean = false;
		private var _owner:FlxSprite;
		private var maxLength:Number = 64;
		private var speed:Number =3;
		
		public static var _UP:Number =UP;
		public static var _DOWN:Number =DOWN;
		public static var _LEFT:Number =LEFT;
		public static var _RIGHT:Number =RIGHT;
		
		
		public function LokeStrike(owner:FlxSprite)
		{
			super(owner.x,owner.y);
			_owner = owner;
			owner["lokeStrike"] = this;
			fixed = true;
			dead = true;
			
			_reset();
		}
		
		public function launch(direction:Number=NaN):void{
			if(isNaN(direction))direction = _owner["_direction"]; //assumes it's lökemaster
			
			if(dead){
				_dynamicLength = 0;
				_direction = direction;
				_draw_back = false;
				_reset();
				dead = false;
			}
		}
		
		
		
		override public function update():void
		{
			var adjustY:Number = 0;
			var adjustX:Number = 0;
			
			if(!dead){
				var h:Number = 1;
				var m:Number = 1;
				var w:Number = 1;
				if(_direction == UP){
						w = 1;
						h = _dynamicLength+=(_draw_back?-1:1)*speed;
						adjustY = -h;
						adjustX = 0;
				}
				else if(_direction == DOWN){
						w = 1;
						h = _dynamicLength+=(_draw_back?-1:1)*speed;
						adjustY = 0;
						adjustX = 0;
				}
				else if(_direction == RIGHT){
					
						w = _dynamicLength+=(_draw_back?-1:1)*speed;
						h = 1;
						adjustY = 0;
						adjustX = 0;
					
				}else if(_direction == LEFT){
					
						w = _dynamicLength+=(_draw_back?-1:1)*speed;
						h = 1;
						adjustY = 0;
						adjustX = -w;
					
				}
				
				if(w>=maxLength || h>=maxLength){
					_draw_back = true;
				}
				
				if(w<0 || h<0){
					dead =true;
					_reset();
				}
				// draw
				createGraphic(w,h,0xff000000);
			}
			super.update();
			// adjust to fit the hand
			switch(_owner["_direction"]){
				case UP:adjustY+=5;adjustX+=12;break;
				case DOWN:adjustY+=10;adjustX+=3;break;
				case LEFT:adjustY+=6;adjustX+=5;break;
				case RIGHT:adjustY+=6;adjustX+=10;break;
			}
			
			x = _owner.x+adjustX;
			y = _owner.y+adjustY;
			
			
		}
		
		private function _reset():void{
			createGraphic(1,1,0xffff0000);
		}
		
		
		
		
	}
}