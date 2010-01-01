package com.godstroke.LokeMasters
{
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		private var walls:Array =new Array();
		private var west_wall:FlxSprite;
		private var north_wall:FlxSprite;
		private var east_wall:FlxSprite;
		private var south_wall:FlxSprite;
		
		public function MenuState()
		{
			FlxG.showCursor();
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"Löke Masters");
			t.size = 16;
			t.color = 0xFF000000
			t.alignment = "center";
			add(t);
			t = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"click to play");
			t.alignment = "center";
			t.color = 0xFF000000
			add(t);
			
			//walls
			west_wall = new FlxSprite(0,0);
			west_wall.createGraphic(1,FlxG.height,0xFF000000);
			walls.push(west_wall);
			add(west_wall);
			
			north_wall = new FlxSprite(0,0);
			north_wall.createGraphic(FlxG.width,1,0xFF000000);
			walls.push(north_wall);
			add(north_wall); 
			
			east_wall = new FlxSprite(FlxG.width-1,0);
			east_wall.createGraphic(1,FlxG.height,0xFF000000);
			walls.push(east_wall);
			add(east_wall); 
			
			south_wall = new FlxSprite(0,FlxG.height-1);
			south_wall.createGraphic(FlxG.width,1,0xFF000000);
			walls.push(south_wall);
			add(south_wall); 
			
			
		}

		override public function update():void
		{
			///*delete this on deploy*/FlxG.switchState(PlayState);
			
			super.update();
			if(FlxG.mouse.justPressed())
				FlxG.switchState(PlayState);
		}
	}
}
