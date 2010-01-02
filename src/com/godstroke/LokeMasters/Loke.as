package com.godstroke.LokeMasters
{
	import flash.geom.Point;
	
	import org.flixel.*;
	

	public class Loke extends FlxSprite
	{
		[Embed(source="../../../data/lokeMaster.png")] private var ImgLokeMaster:Class;
		public var _direction:Number = DOWN; //default facing direction
		public var walking_direction:Number = 4; // UP DOWN .. 4 for none
		private var _lokeStrike:LokeStrike = null;
		private var idleCounter:Number = 0;
		private var currentTarget:Point;
		public var _health:Number = 5;
		
		public var currentProjectileDamage:Number = 1; // varies from PaperItem get
		
		public function Loke(X:int=0, Y:int=0)
		{
			super(X, Y);
			currentTarget = new Point(X,Y);
			loadGraphic(ImgLokeMaster,true,true,16,16);
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
			maxVelocity.x = runSpeed;
			maxVelocity.y = runSpeed;
			
			play("idle");
		}
		
		public function set lokeStrike(ls:LokeStrike):void{
			_lokeStrike = ls;
		}
		
		public function blackOut():void{
			dead = true;
			play("dead");
		}
		
		public function hit(damage:Number):void{
			trace("ene hit by "+damage);
			_health-=damage;
			if(_health<=0){
				trace("die son of a BEACH !")
				blackOut();
				health = 0;
			}
		}
		
		override public function update():void
		{
			//MOVEMENT
			acceleration.x = 0;
			acceleration.y = 0;
			
			velocity.x = 0;
			velocity.y = 0;
			
			if(dead){
				super.update();
				return;
			}
			
			if(walking_direction == LEFT)
			{
				idleCounter = 0;
				facing = LEFT;
				_direction = LEFT;
				//acceleration.x -= drag.x;
				velocity.x = -maxVelocity.x;
				play("walk_right")
			}
			else if(walking_direction == RIGHT)
			{
				idleCounter = 0;
				facing = RIGHT;
				_direction = RIGHT;
				//acceleration.x += drag.x;
				velocity.x = maxVelocity.x;
				play("walk_right")
			}
			else if(walking_direction == UP)
			{
				idleCounter = 0;
				//facing = UP;
				_direction = UP;
				//acceleration.y -= drag.y;
				//acceleration.y = -maxVelocity.y
				velocity.y = -maxVelocity.y;
				play("walk_up")
			}
			else if(walking_direction == DOWN)
			{
				idleCounter = 0;
				//facing = DOWN;
				_direction = DOWN;
				//acceleration.y += drag.y;
				velocity.y = maxVelocity.y;
				play("walk_down")
			}
			else{
				// heres a bit complex but explains itself.
				if(_direction == UP && idleCounter>=0)play("idle_up",true);
				if(_direction == DOWN && idleCounter>=0)play("idle_down",true);
				if(_direction == LEFT && idleCounter>=0)play("idle_right",true);
				if(_direction == RIGHT && idleCounter>=0)play("idle_right",true);
				if(idleCounter>=0)idleCounter += FlxG.elapsed;
				if(idleCounter>=3 && idleCounter>=0){
					idleCounter = -1;
					_direction = DOWN;
					play("idle");
				}
			}
			
			if(FlxG.keys.justPressed("SPACE")){
				idleCounter = 0;
				if(_lokeStrike){
					_lokeStrike.launch();
				}
			}
			
			super.update();
			
			AI();
		}
		
		private function AI():void{
			
		}
		
	}
}