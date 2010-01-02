package com.godstroke.LokeMasters
{
	import org.flixel.FlxCore;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Pen extends FlxSprite
	{
		[Embed(source="../../../data/pen.png")] private var ImgPen:Class;
		public var life:Number = 1000;
		private var hitableCounter:Number = 0;
		private var canHit:Boolean = true;
		
		public function Pen(X:int=0, Y:int=0){
			super(X, Y);
			loadGraphic(ImgPen,true,true,10,10);
			addAnimation("idle",[0],1,false);
		}
		
		public function hit(n:Number=1):void{
			if(!canHit)return;
			
			life-=n;
			canHit =false;
			if(life<=0){
				life = 0;
				dead = true;
				destroy();
				//visible =false;
				this.flicker(0.5);
			}
		}
		
		public function getItem(getter:FlxCore):void{
			hit(1001); // self destruct
			//FlxG.state["getPapers"](_quantity);
			getter["getPen"]();
		}
		
		override public function update():void
		{
			if(!canHit){
				hitableCounter+=FlxG.elapsed;
				if(hitableCounter>0.4){
					canHit =true;
				}
			}else{
				hitableCounter = 0;
			}
			
			if(dead && !flickering()){
				visible =false;
			}
			
			super.update();
		}		
	}
}