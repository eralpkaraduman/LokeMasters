package com.godstroke.LokeMasters
{
	import org.flixel.FlxCore;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class PaperItem extends FlxSprite
	{
		[Embed(source="../../../data/paper.png")] private var ImgPaper:Class;
		public var life:Number = 1000;
		private var hitableCounter:Number = 0;
		private var canHit:Boolean = true;
		private var _quantity:uint = 1;
		private var _damage:Number;
		
		public function PaperItem(X:int=0, Y:int=0,quantity:uint=1,damage:Number=1){
			super(X, Y);
			_quantity = quantity;
			loadGraphic(ImgPaper,true,true,6,6);
			addAnimation("idle",[0],1,false);
			_damage = damage;
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
			getter["currentProjectileDamage"] = _damage;
			getter["getPapers"](_quantity);
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