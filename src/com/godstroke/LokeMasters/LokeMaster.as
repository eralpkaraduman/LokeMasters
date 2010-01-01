package com.godstroke.LokeMasters
{
	import org.flixel.*;
	

	public class LokeMaster extends FlxSprite
	{
		[Embed(source="../../../data/lokeMaster.png")] private var ImgLokeMaster:Class;
		public var _direction:Number = DOWN; //default facing direction
		private var _lokeStrike:LokeStrike = null;
		
		public function LokeMaster(X:int=0, Y:int=0)
		{
			super(X, Y);
			loadGraphic(ImgLokeMaster,true,true,16);
			addAnimation("idle",[2,1,2,0],1,true);
			addAnimation("dead",[6,5,4,3],3,true);
			addAnimation("hit",[7],0,false);
			//addAnimation("walk_left",[8,10,9,10],3,true);
			addAnimation("walk_right",[11,13,12,13],3,true);
			addAnimation("walk_up",[14,16,15,16],3,true);
			addAnimation("walk_down",[17,19,18,19],3,true);
			
			addAnimation("idle_down",[19],1,false);
			addAnimation("idle_up",[16],1,false);
			addAnimation("idle_right",[13],1,false);
			
			var runSpeed:uint = 70;
			//drag.x = runSpeed*2;
			//drag.y = runSpeed*2;
			//acceleration.y = 420;
			//_jumpPower = 200;
			maxVelocity.x = runSpeed;
			maxVelocity.y = runSpeed;
			
			play("idle");
		}
		
		public function set lokeStrike(ls:LokeStrike):void{
			_lokeStrike = ls;
		}
		
		override public function update():void
		{
			//MOVEMENT
			acceleration.x = 0;
			acceleration.y = 0;
			
			velocity.x = 0;
			velocity.y = 0;
			
			if(FlxG.keys.LEFT)
			{
				facing = LEFT;
				_direction = LEFT;
				//acceleration.x -= drag.x;
				velocity.x = -maxVelocity.x;
				play("walk_right")
			}
			else if(FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				_direction = RIGHT;
				//acceleration.x += drag.x;
				velocity.x = maxVelocity.x;
				play("walk_right")
			}
			else if(FlxG.keys.UP)
			{
				//facing = UP;
				_direction = UP;
				//acceleration.y -= drag.y;
				//acceleration.y = -maxVelocity.y
				velocity.y = -maxVelocity.y;
				play("walk_up")
			}
			else if(FlxG.keys.DOWN)
			{
				//facing = DOWN;
				_direction = DOWN;
				//acceleration.y += drag.y;
				velocity.y = maxVelocity.y;
				play("walk_down")
			}
			else{
				if(_direction == UP)play("idle_up",true);
				if(_direction == DOWN)play("idle_down",true);
				if(_direction == LEFT)play("idle_right",true);
				if(_direction == RIGHT)play("idle_right",true);
				
				//play("idle");
			}
			/* if(FlxG.keys.justPressed("X") && !velocity.y)
			{
			} */
			
			if(FlxG.keys.justPressed("SPACE")){
				if(_lokeStrike){
					_lokeStrike.launch();
				}
			}
			
			super.update();
		}
		
	}
}