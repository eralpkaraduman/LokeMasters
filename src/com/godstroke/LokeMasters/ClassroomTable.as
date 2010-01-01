package com.godstroke.LokeMasters
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class ClassroomTable extends FlxSprite
	{
		[Embed(source="../../../data/table.png")] private var ImgTable:Class;
		public var life:Number = 100;
		private var hitableCounter:Number = 0;
		private var canHit:Boolean = true;
		
		public function ClassroomTable(X:int=0, Y:int=0)
		{
			super(X, Y);
			loadGraphic(ImgTable,true,true,32,16);
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
		
		override public function update():void
		{
			if(!canHit){
				hitableCounter+=FlxG.elapsed;
				trace(hitableCounter);
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
		
		private function explode():void{
			/* var e:FlxEmitter = new FlxEmitter(x,y,0.09);
			e.setXVelocity(15,15);
			e.setYVelocity(5,5);
			e.setRotation(-720,-720);
			var a:Array=new Array();
			for(var i:Number = 0; i < 10; i++)
			{
				var s:FlxSprite = new FlxSprite();
				s.createGraphic(3,3,0xff000000);
				a.push(FlxG.state.add(s));
			}
			e.loadSprites(a);
			FlxG.state.add(e); */
			
		}
		
	}
}