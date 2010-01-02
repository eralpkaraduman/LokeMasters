package com.godstroke.LokeMasters
{
	import org.flixel.FlxCore;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	
	public class PaperThrowable extends FlxSprite
	{
		[Embed(source="../../../data/paper.png")] private var ImgPaper:Class;
		public var life:Number = 1000;
		public var thrown:Boolean = false;
		public var deadly:Boolean = false
		public var damage:Number = 1;
		private var speed:Number =180;
		
		public function PaperThrowable(X:int=0, Y:int=0){
			super(X, Y);
			loadGraphic(ImgPaper,true,true,6,6);
			addAnimation("idle",[0],1,false);
			visible = false;
			trace("created projectile");
		}
		
		public function throwIt(towards:Number):void{
			switch(towards){
				case LEFT: velocity.x = -speed;break;
				case RIGHT: velocity.x = speed;break;
				case UP: velocity.y = -speed;break;
				case DOWN: velocity.y = speed;break;				
			}
			thrown =true;
			dead = false;
			visible =true;
			trace("thrown projectile");
		}
		
		override public function update():void
		{
			
			if(thrown){
				angle += 5;
			}else{
				//dead = true;
			}
			
			super.update();
		}
		
		override public function hitFloor(Contact:FlxCore=null):Boolean
		{
			makeSpare();
			return super.hitFloor();
		}
		
		override public function hitCeiling(Contact:FlxCore=null):Boolean
		{
			makeSpare();
			return super.hitFloor();
		}
		
		override public function hitWall(Contact:FlxCore=null):Boolean
		{
			makeSpare();
			return super.hitFloor();
		}
		
		private function makeSpare(reuse:Boolean=true):void{
			thrown = false;
			dead =true;
			velocity.x = 0;velocity.y = 0;
			visible = false;
			//replace it by item versioni sou user can pick it up than re-throw
			if(reuse)FlxG.state["createPaperItem"](x,y,damage);
		}
		
		public function justHitSomething():void{
			makeSpare(false);
		}	
	}
}